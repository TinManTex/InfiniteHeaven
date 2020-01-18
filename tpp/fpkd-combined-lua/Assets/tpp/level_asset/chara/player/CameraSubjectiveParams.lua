




CameraSubjectiveParams = {


Definitions = {

	
	ActionList = {

		
		"ACT_Stand",
		
		"ACT_Squat",
		
		"ACT_Crawl",
		
		"ACT_HorseDefault",
		
		"ACT_StrykerDefault",
		
		"ACT_StrykerSubWeapon",
		
		"ACT_CqcDefault",
		
		"ACT_AntiAircraftGun",
		
		"ACT_Turret",
		
		"ACT_SearchLight",
		
		"ACT_VehicleDefault",
		
		"ACT_LightVehicleDefault",
		
		"ACT_TruckDefault",
		
		"ACT_HeliDefault",

		
		"ACT_MBTerminal",
		"ACT_MBTerminalCrawl",
		"ACT_MBTerminalNormalVehicle",
		"ACT_MBTerminalCombatVehicle",
		"ACT_MBTerminalHeli",

		
		"ACT_OnBed",
		"ACT_OnBed1_2_Shake1",
		"ACT_OnBed1_2_Shake2",
		"ACT_OnBed1_2_Shake3",
		"ACT_OnBed1_2_DoctorInterview",
		
		"ACT_OnBed2",
		
		"ACT_UnderBed",
		"ACT_UnderBedRight",
		"ACT_UnderBedLeft",
		"ACT_UnderBedMove",
		
		"ACT_ShootQuiet",
		
		"ACT_ShootVolgin",
		
		"ACT_Massacre",
	},
	
},



BasicParams = {

	
	DefaultParam = {
		
		
		distance				= 0,
		
		
		offset				= Vector3( 0.0, 0.0, 0.0 ),
		
		
		rotXMin				= -70,
		
		
		rotXMax				= 55,
		
		
		rotVelMaxX			= 45.0,
		
		
		rotVelMaxY			= 90,
		
		
		rotVelAccelFrame		= 12,
		
		
		rotVelFadeFrame		= 1,
		
		
		focalLength			= 36,
		
		
		offsetInterpTime		= 0.15,
		
		
		distanceInterpTime	= 0.15,
		
		
		focalLengthInterpTime	= 0.15,
		
		
		focusDistanceInterpTime	= 0.67,
		
		
		attachType			= "Head",

		
		enableAutoFocus		=  true,
		
		

		aperture					= 1.875,
		
		
		apertureInterpTime		= 0.23,

		
		disableFrontBokeh			= true,

		
		
		

		
		enableLockOn			= true,
		
		
		enableAssist			= false,
		
		
		assistRangeAngleXMax	= 16,
		
		
		assistRangeAngleYMax	= 20,
		
		
		assistForce			= 0.95,

		
		PresetDefault = {
			
			{
				
				presetName	= "hospital_vga",
				offset = Vector3( 0.0, 0.1, 0.5 ),
			},
			
		},
	}, 
	

	
	Params = {

	
	
	
		
		
		{
			actionName	= "ACT_Stand",
			
		},
		
		
		{
			actionName	= "ACT_Squat",

		},

		
		{
			actionName	= "ACT_Crawl",
			offset		= Vector3( 0.0, 0.04, 0.0 ),
			rotXMin		= -32,
			rotXMax		= 27,
		},
		
		
		{
			actionName	= "ACT_HorseDefault",
			
		},
		
		
		{
			actionName	= "ACT_StrykerDefault",
			
			
			offset				= Vector3( 0.1, 0.65, 0.9 ),
			
			rotXMin				= -13.25,
			
			rotXMax				= 15,
			
			rotVelMaxX			= 24,
			
			rotVelMaxY			= 28,
			
			rotVelAccelFrame		= 20,
			
			focalLength			= 36,
			
			
			attachType			= "Manual",
			
			enableLockOn			= false,
			
			enableAssist			= false,

			
			distanceInterpTime	= 0.0,
		},
		
		
		{
			actionName	= "ACT_StrykerSubWeapon",
			
			
			distance				= 1.0,
			
			offset				= Vector3( 0.0, 1.02, 0.5 ),
			
			rotXMin				= -30,
			
			rotXMax				= 30,
			
			rotVelMaxX			= 55,
			
			rotVelMaxY			= 75,
			
			rotVelAccelFrame		= 20,
			
			focalLength			= 21,
			
			attachType			= "Manual",
			
			enableLockOn			= false,
			
			enableAssist			= false,
		},
		
		
		{
			actionName	= "ACT_VehicleDefault",
			
			offset			= Vector3( 0.0, 0.1, 0.0 ),
			rotXMin			= -60,
			rotXMax			= 12,
			rotYMin			= -80,
			rotYMax			= 80,
		},

		
		{
			actionName	= "ACT_LightVehicleDefault",
			
			offset			= Vector3( 0.0, 0.1, 0.0 ),
			rotXMin			= -60,
			rotXMax			= 12,
			rotYMin			= -80,
			rotYMax			= 80,
			
			focalLength			= 26,
		},

		
		{
			actionName	= "ACT_TruckDefault",
			
			offset			= Vector3( 0.0, 0.1, 0.0 ),
			rotXMin			= -20,
			rotXMax			= 3,
			rotYMin			= -80,
			rotYMax			= 80,
			
			focalLength			= 26,
		},

		
		{
			actionName	= "ACT_HeliDefault",

			
			attachType	= "Manual",

			offset			= Vector3( 0.0, -0.05, 0.0 ),
			
			rotXMin			= -20,
			
			rotXMax			= 50,
			
			rotYMin			= -90,
			
			rotYMax			= 90,
		},

		
		{
			actionName = "ACT_MBTerminal",
			
			rotXMin			= -20,
			
			rotXMax			= 50,
		},
		{
			actionName = "ACT_MBTerminalCrawl",
			
			rotXMin			= -20,
			
			rotXMax			= 20,
		},

		
		{
			actionName	= "ACT_MBTerminalNormalVehicle",
			
			offset			= Vector3( 0.0, 0.1, 0.0 ),
			rotXMin			= -14,
			rotXMax			= 3,
			rotYMin			= -80,
			rotYMax			= 80,
			
			focalLength			= 26,
		},
		
		
		{
			actionName	= "ACT_MBTerminalCombatVehicle",
			
			offset			= Vector3( 0.0, 0.1, 0.0 ),
			
			rotXMin				= -30,
			
			rotXMax				= 15,
			
			rotVelMaxX			= 35,
			
			rotVelMaxY			= 43,
			
			rotVelAccelFrame		= 5,
			
			focalLength			= 26,
		},

		
		{
			actionName	= "ACT_MBTerminalHeli",

			
			attachType	= "Manual",

			
			rotXMin			= -20,
			
			rotXMax			= 20,
			
			rotYMin			= -40,
			
			rotYMax			= 40,
		},
		
		
		{
			actionName	= "ACT_CqcDefault",
			
		},

		
		{
			actionName	= "ACT_AntiAircraftGun",
			
			
			attachType			= "Manual",

			
			distance				= 0.5,
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
			
			rotXMin				= -20,
			
			rotXMax				= 20,
			
			rotVelMaxX			= 46,
			
			rotVelMaxY			= 64,
			
			rotVelAccelFrame		= 40,
			
			rotVelFadeFrame		= 16.5,
			
			enableLockOn			= false,
			
			enableAssist			= false, 
		},

		
		{
			actionName	= "ACT_Turret",
			
			
			distance				= 0.5,
			
			offset				= Vector3( 0.0, 0.1, 0.5 ),
			
			rotXMin				= -20,
			
			rotXMax				= 20,
			
			
			
			
			
			rotVelMaxX			= 60,
			
			rotVelMaxY			= 110,
			
			enableLockOn			= false,
			
			enableAssist			= false, 
		},
		
		
		{
			actionName	= "ACT_SearchLight",
			
			offset				= Vector3( 0.0, 1.70, 0 ),
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_C",
			
			
			rotVelAccelFrame		= 40,
		},
		
		
		{
			actionName = "ACT_OnBed",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -35,
		
			
			rotXMax				= 13,
		
			
			rotYMin				= -50,
		
			
			rotYMax				= 45,

			
			rotVelMaxX			= 10,
		
			
			rotVelMaxY			= 10,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 18,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			baseAxisRotX		=	-25,
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",

			
			enableAutoFocus	= false,
		},

		
		{
			actionName = "ACT_OnBed1_2_Shake1",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -35,
		
			
			rotXMax				= 13,
		
			
			rotYMin				= -70,
		
			
			rotYMax				= 50,

			
			rotVelMaxX			= 25,
		
			
			rotVelMaxY			= 25,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 18,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			baseAxisRotX		=	-25,
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",
		},		

		
		{
			actionName = "ACT_OnBed1_2_Shake2",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -35,
		
			
			rotXMax				= 13,
		
			
			rotYMin				= -70,
		
			
			rotYMax				= 50,

			
			rotVelMaxX			= 25,
		
			
			rotVelMaxY			= 25,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 18,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			baseAxisRotX		=	-25,
			
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",

			
			enableAutoFocus	= false,			
		},

		
		{
			actionName = "ACT_OnBed1_2_Shake3",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -35,
		
			
			rotXMax				= 13,
		
			
			rotYMin				= -70,
		
			
			rotYMax				= 50,

			
			rotVelMaxX			= 25,
		
			
			rotVelMaxY			= 25,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 18,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			baseAxisRotX		=	-25,
			
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",

			
			enableAutoFocus	= false,			
		},

		
		{
			actionName = "ACT_OnBed1_2_DoctorInterview",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -35,
		
			
			rotXMax				= 13,
		
			
			rotYMin				= -40,
		
			
			rotYMax				= 2,

			
			rotVelMaxX			= 25,
		
			
			rotVelMaxY			= 25,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 18,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			baseAxisRotX		=	-25,
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",

			
			enableAutoFocus	= false,			
		},
		
		
		{
			actionName = "ACT_OnBed2",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -60,
		
			
			rotXMax				= 29,
		
			
			rotYMin				= -89,
		
			
			rotYMax				= 89,

			
			rotVelMaxX			= 45,
		
			
			rotVelMaxY			= 45,
		
			
			rotVelAccelFrame		= 30,
		
			
			rotVelFadeFrame		= 10,
		
			
			focalLength			= 23,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,

			
			baseAxisRotX		=	-10,
			
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",

			
			enableAutoFocus	= false,			
		},

		
		{
			actionName = "ACT_UnderBed",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.6 ),


			
			rotXMin				= -10,
		
			
			rotXMax				= 5,


			
			rotYMin				= -65,
		
			
			rotYMax				= 65,

			
			rotVelMaxX			= 100,
			
			
			rotVelMaxY			= 130,
			
			
			rotVelAccelFrame		= 20,
			
			
			rotVelFadeFrame		= 5,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			attachType			= "None",
			
			
			
		},

		
		{
			actionName = "ACT_UnderBedRight",

			presetName = "hospital",
			
			
			offset				= Vector3( -0.4, 0.0, 0.6 ),
		
			
			rotXMin				= -10,
		
			
			rotXMax				= 0,

			
			rotYMin				= -65,
		
			
			rotYMax				= 65,

			
			rotVelMaxX			= 100,
			
			
			rotVelMaxY			= 130,
			
			
			rotVelAccelFrame		= 20,
			
			
			rotVelFadeFrame		= 5,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			attachType			= "None",
			
			
			
		},		

		
		{
			actionName = "ACT_UnderBedLeft",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.4, 0.0, 0.6 ),
		
			
			rotXMin				= -10,
		
			
			rotXMax				= 0,

			
			rotYMin				= -65,
		
			
			rotYMax				= 80,

			
			rotVelMaxX			= 100,
			
			
			rotVelMaxY			= 130,
			
			
			rotVelAccelFrame		= 20,
			
			
			rotVelFadeFrame		= 5,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			attachType			= "None",
			
			
			
		},

		
		{
			actionName = "ACT_UnderBedMove",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.6 ),
		
			
			rotXMin				= -10,
		
			
			rotXMax				= 5,

			
			rotYMin				= -65,
		
			
			rotYMax				= 65,

			
			rotVelMaxX			= 100,
			
			
			rotVelMaxY			= 130,
			
			
			rotVelAccelFrame		= 20,
			
			
			rotVelFadeFrame		= 5,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_A",
		},		
		
		
		{
			actionName = "ACT_ShootQuiet",

			presetName = "hospital",
			
			
			offset				= Vector3( -0.3, 0.2, -0.6 ),
		
			
			rotXMin				= -15,
		
			
			rotXMax				= 15,
		
			
			rotYMin				= 0,
		
			
			rotYMax				= 90,

			
			rotVelMaxX			= 30,
		
			
			rotVelMaxY			= 30,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			attachType			= "Head",
			
			
		},

		
		{
			actionName = "ACT_ShootVolgin",

			presetName = "hospital",
			
			
			offset				= Vector3( -0.3, 0.2, -0.6 ),
		
			
			rotXMin				= -20,
		
			
			rotXMax				= 20,
		
			
			rotYMin				= -20,
		
			
			rotYMax				= 20,

			
			rotVelMaxX			= 60,
		
			
			rotVelMaxY			= 60,
		
			
			rotVelAccelFrame		= 20,
		
			
			rotVelFadeFrame		= 10,
		
			
			focalLength			= 21,
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			attachType			= "Head",
			
			
		},

		
		{
			actionName = "ACT_Massacre",

			presetName = "hospital",
			
			
			offset				= Vector3( 0.0, 0.0, 0.0 ),
		
			
			rotXMin				= -60,
		
			
			rotXMax				= 60,
		
			
			rotYMin				= -45,
		
			
			rotYMax				= 45,

			
			rotVelMaxX			= 30,
		
			
			rotVelMaxY			= 30,
		
			
			rotVelAccelFrame		= 40,
		
			
			rotVelFadeFrame		= 20,
		
			
			
		
			
			offsetInterpTime		= 0.3,
		
			
			distanceInterpTime	= 0.3,
		
			
			focalLengthInterpTime	= 0.3,
		
			
			
			attachType			= "Head",
		},
	}, 
	
}, 



FixedParams = {
	
	
	DefaultParam = {
		
		
		stickMargin				= ( 24 / 255 ),
		
		
		stickMarginByAnotherAxis	= 0.15,
		
		
		distanceInterpTimeAtStart	= 0.0,
		
		
		offsetInterpTimeAtStart	= 0.05,
		
		
		basePosInterpTime			= 0.3,
		
		
		collisionInterpTime		= 0.15,
		
		
		bezierControlTime			= 0.4,
		
		
		bezierControlRate			= 0.8,

		
		
		
		

		
		stockChangeInterpTime			= 0.2,
		
		
		lockOnInterpTime				= 0.1,

		
		lockOnAssistKeepTime			= 0.4,
		
		
		wobblingInterpTime			= 0.1,
		
		
		fixedAttackTargetLimitDist		= 2.0,
		
		
		assistRangeAngleMaxExcessRate	= 1.05,

		
		assistInterpRate				= 0.00,

		
		assistForceForManualRotaionMin	= 0.70,

		
		assistForceForManualRotaionMax	= 0.85,

		
		assistForceForMove		= 0.80,

		
		assistForceInLockOnKeeging		= 1.0,
		
	},

}, 
	

ShakeParams = {
	
	
	DefaultParam = {
		
		
		rangePosX	= 0,
		
		
		rangePosY	= 0,

		
		rangePosZ	= 0,
		
		
		rangeRotX	= 0,
		
		
		rangeRotY	= 0,
		
		
		rangeRotZ	= 0,

		
		cyclePos		= 0,
		
		
		cycleRot		= 0,
		
		
		interpTime	= 0,
		
		
		speedMode	= false,
		
	},

	Params = {

		
		{
			name		= "ACT_OnBed",

			
			rangePosX	= 0.01,
		
			
			rangePosY	= 0.015,

			
			rangePosZ	= 0,
		
			
			rangeRotX	= 0.2,
		
			
			rangeRotY	= 0.2,
		
			
			rangeRotZ	= 0,

			
			cyclePos		= 4,
		
			
			cycleRot		= 5,
		
			
			interpTime	= 0.3,
		
			
			speedMode	= false,
		
		},

		
		{
			name		= "ACT_OnBed1_2_Shake1",

			
			rangePosX	= 0.01,
		
			
			rangePosY	= 0.015,

			
			rangePosZ	= 0,
		
			
			rangeRotX	= 0.2,
		
			
			rangeRotY	= 0.2,
		
			
			rangeRotZ	= 0,

			
			cyclePos		= 4,
		
			
			cycleRot		= 5,
		
			
			interpTime	= 0.3,
		
			
			speedMode	= false,
		
		},

		
		{
			name		= "ACT_OnBed1_2_Shake2",

			
			rangePosX	= 0.01,
		
			
			rangePosY	= 0.015,

			
			rangePosZ	= 0,
		
			
			rangeRotX	= 0.15,
		
			
			rangeRotY	= 0.15,
		
			
			rangeRotZ	= 0,

			
			cyclePos		= 3,
		
			
			cycleRot		= 4,
		
			
			interpTime	= 0.3,
		
			
			speedMode	= false,
		
		},

		
		{
			name		= "ACT_OnBed1_2_Shake3",

			
			rangePosX	= 0.0,
		
			
			rangePosY	= 0.0,

			
			rangePosZ	= 0,
		
			
			rangeRotX	= 0.0,
		
			
			rangeRotY	= 0.0,
		
			
			rangeRotZ	= 0,

			
			cyclePos		= 0,
		
			
			cycleRot		= 0,
		
			
			interpTime	= 3.0,
		
			
			speedMode	= false,
		
		},		
	},

}, 

} 

