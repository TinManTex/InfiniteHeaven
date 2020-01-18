




CameraTpsParams = {


Definitions = {

	
	ActionList = {

		
		"ACT_Stand",
		
		"ACT_Squat",
		
		"ACT_Crawl",
		
		"ACT_PlaceHoldStand",
		
		"ACT_PlaceHoldSquat",
		
		"ACT_PlaceHoldPut",
		
		"ACT_PlaceHoldCrawl",
		
		"ACT_HorseDefault",
		
		"ACT_StrykerDefault",
		
		"ACT_StrykerSubWeapon",
		
		"ACT_CqcDefault",
		
		"ACT_CqcSquat",
		
		"ACT_AntiAircraftGun",
		
		"ACT_Turret",
		
		"ACT_SearchLight",
		
		"ACT_VehicleDefault",
		
		"ACT_LightVehicleDefault",
		
		"ACT_TruckDefault",
		
		"ACT_HeliDefault",
		
		"ACT_HorseVolginChase",
		
		"ACT_CarryStand",
		
		"ACT_CarrySquat",

		
		"ACT_BehindStandPeepThrow",
		"ACT_BehindSquatPeepThrow",		
	},

},



BasicParams = {

	
	DefaultParam = {

		
		distance				= 1.2,

		
		offset				= Vector3( -0.5, 0.76, 0.0 ),

		
		rotXMin				= -70,

		
		rotXMax				= 55,

		
		rotVelMaxX			= 45,

		
		rotVelMaxY			= 90,

		
		rotVelAccelFrame		= 12,

		
		rotVelFadeFrame		= 1,

		
		focalLength			= 22,

		
		offsetInterpTime		= 0.315,

		
		distanceInterpTime	= 0.15,

		
		focalLengthInterpTime	= 0.15,

		
		attachType			= "None",

		

		enableAutoFocus		=  true,

		
		aperture				= 1.875,

		
		
		apertureInterpTime		= 0.23,

		
		disableFrontBokeh			= true,

		
		PresetDefault = {
			
			{
				
				presetName	= "hospital_entrance",
			},
		},

		
		
		

		
		enableLockOn			= true,

		
		enableAssist			= true,

		
		assistRangeAngleXMax	= 16,

		
		assistRangeAngleYMax	= 20,

		
		assistForce			= 0.95,

	}, 


	
	Params = {

	
	
	

		
		{
			actionName	= "ACT_Stand",

		},

		
		{
			actionName	= "ACT_Squat",

			
			offset				= Vector3( -0.5, 0.4, 0.0 ),
		},

		
		{
			actionName	= "ACT_Crawl",

			
			distance				= 1.5,
			
			offset				= Vector3( -0.4, 0.15, 0.0 ),
			
			rotXMin				= -40,
			
			rotXMax				= 40,
		},
		
		{
			actionName	= "ACT_PlaceHoldStand",
			distance	= 3.1,
			offset				= Vector3( -0.5, 0.65, 0.0 ),
		},

		
		{
			actionName	= "ACT_PlaceHoldSquat",
			distance	= 2.5,
			
			offset				= Vector3( -0.5, 0.3, 0.0 ),
		},

		
		{
			actionName	= "ACT_PlaceHoldPut",
			distance	= 2.5,
			
			offset				= Vector3( -0.5, -0.1, 0.0 ),
		},

		
		{
			actionName	= "ACT_PlaceHoldCrawl",

			
			distance				= 1.5,
			
			offset				= Vector3( -0.4, 0.15, 0.0 ),
			
			rotXMin				= -40,
			
			rotXMax				= 40,
		},
		
		
		{
			actionName	= "ACT_HorseDefault",

			
			offset				= Vector3( -0.4, 0.4, 0.0 ),
			
			rotXMin				= -40,
			
			rotXMax				= 40,
		},

		
		{
			actionName	= "ACT_StrykerDefault",

			
			distance				= 5.0,
			
			offset				= Vector3( -1.5, 1.0, 0.0 ),
			
			rotXMin				= -13.25,
			
			rotXMax				= 15,
			
			rotVelMaxX			= 35,
			
			rotVelMaxY			= 43,
			
			rotVelAccelFrame		= 20,
			
			attachType			= "Manual",
			
			enableLockOn			= false,
			
			enableAssist			= false,
		},

		
		{
			actionName	= "ACT_StrykerSubWeapon",

			
			distance				= 1.0,
			
			offset				= Vector3( -0.5, 1.25, 0.0 ),
			
			rotXMin				= -30,
			
			rotXMax				= 30,
			
			rotVelMaxX			= 55,
			
			rotVelMaxY			= 75,
			
			rotVelAccelFrame		= 20,
			
			attachType			= "Manual",
			
			enableLockOn			= false,
			
			enableAssist			= false,
		},

		
		{
			actionName	= "ACT_VehicleDefault",

		},

		
		{
			actionName	= "ACT_LightVehicleDefault",
			
			distance				= 2.75,
			
			offset				= Vector3( -0.625, 0.75, 0.0 ),

		},

		
		{
			actionName	= "ACT_TruckDefault",
			
			distance				= 4.5,
			
			offset				= Vector3( -1.25, 0.75, 0.0 ),
		},

		
		{
			actionName	= "ACT_CqcDefault",
			
			rotXMax				= 25,
		},

		
		{
			actionName	= "ACT_CqcSquat",

			
			offset				= Vector3( -0.6, 0.3, 0.0 ),
			
			rotXMax				= 20,
			
			rotXMin				= -40,
		},

		
		{
			actionName	= "ACT_AntiAircraftGun",

			
			attachType			= "Manual",
			
			distance				= 1.45,
			
			offset				= Vector3( -0.35, 0.335 ,-0.42 ),
			
			rotXMin				= -20,
			
			rotXMax				= 20,
			
			rotVelMaxX			= 46,
			
			rotVelMaxY			= 64,
			
			rotVelAccelFrame		= 40,
			
			rotVelFadeFrame		= 16.5,
			
			enableLockOn			= false,
			
			enableAssist			= false,
			
			focalLength			= 22,
		},

		
		{
			actionName	= "ACT_Turret",

			
			distance				= 1.4,
			
			offset				= Vector3( -0.45, 0.8, 0.0 ),
			
			rotXMin				= -20,
			
			rotXMax				= 20,
			
			rotVelMaxX			= 60,
			
			rotVelMaxY			= 110,
			
			enableLockOn			= false,
			
			enableAssist			= false,
			
			focalLength			= 19,
		},

		
		{
			actionName	= "ACT_SearchLight",

			
			distance				= 1.0,
			
			offset				= Vector3( -0.5, 1.60, 0.0 ),
			
			attachType			= "GlobalMotionPoint",
			attachPointName		= "MTP_GLOBAL_C",
		},
		
		
		{
			actionName	= "ACT_HeliDefault",

			
			attachType			= "Manual",

			
			distance			= 0.75,

			
			offset				= Vector3( -0.35, 0.0, 0.0 ),

			
			rotXMin			= -20,
			
			rotXMax			= 50,
			
			rotYMin			= -97,
			
			rotYMax			= 97,
		},

		
		{
			actionName	= "ACT_CarryStand",

			distance	= 1.5,

			
			offset				= Vector3( -0.75, 0.76, 0.0 ),
		},

		
		{
			actionName	= "ACT_CarrySquat",

			distance	= 1.5,
			
			
			offset				= Vector3( -0.75, 0.4, 0.0 ),
		},

		
		{
			actionName	= "ACT_BehindStandPeepThrow",
			distance	= 2.5,
			
			offset				= Vector3( -1.25, 0.75, 0.0 ),
		},
		{
			actionName	= "ACT_BehindSquatPeepThrow",
			distance	= 2.5,
			
			offset				= Vector3( -1.25, 0.4, 0.0 ),
		},
		
	
	
	

		
		{
			actionName	= "ACT_HorseVolginChase",

			
			presetName	= "hospital_entrance",

			
			distance				= 1.2,
			
			
			offset				= Vector3( -0.425, 0.05, -0.10 ),
			
			rotXMin				= -20,
			
			rotXMax				= 30,
			
			focalLengthInterpTime	= 1.5,
			
			focalLength			= 25,

			
			enableAutoFocus		=  false,
			
			focusDistance 		= 4.0,
			
			aperture			= 1.5,
			
			shutterSpeed	=	0.04,
		},
		
	}, 

}, 



FixedParams = {

	
	DefaultParam = {

		
		stickMargin				= ( 24 / 255 ),

		
		stickMarginByAnotherAxis	= 0.15,

		
		distanceInterpTimeAtStart	= 0.16,

		
		offsetInterpTimeAtStart	= 0.15,

		
		basePosInterpTime			= 0.3,

		
		collisionInterpTime		= 0.15,

		
		bezierControlTime			= 0.4,

		
		bezierControlRate			= 0.78,


		
		
		

		
		stockChangeInterpTime			= 0.2,

		
		lockOnInterpTime				= 0.1,

		
		lockOnAssistKeepTime			= 0.4,

		
		wobblingInterpTime			= 0.1,

		
		fixedAttackTargetLimitDist		= 2.0,

		
		fixedAttackTargetLimitDistForStockChange		= 5.0,

		
		assistRangeAngleMaxExcessRate	= 1.05,

		
		assistInterpRate				= 0.00,

		
		assistForceForManualRotaionMin	= 0.7,

		
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

		
		rangeRotX	= 0.0,

		
		rangeRotY	= 0.0,

		
		rangeRotZ	= 0.0,

		
		cyclePos		= 0,

		
		cycleRot		= 0,

		
		interpTime	= 0,

		
		speedMode	= false,

	},

	Params = {

	},

}, 

} 

