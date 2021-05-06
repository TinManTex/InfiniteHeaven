


CharaTppCommonVehicle = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
	"Nav",
},

pluginIndexEnumInfoName = "TppStrykerPluginIndexDefine",

OnCreate = function( chara )








	chara:InitPluginPriorities {
		"Root",
		"DemoAction",
		"DeadAction",
		"NormalAction",
	}

	chara:AddPlugins{
	
		
		"PLG_STRYKER_BODY",
		ChBodyPlugin{
			name	= "MainBody",
			parts 	= "parts",
			useCharacterController = false,


			motionLayers 	= { "Left", "Right", },
			maxMotionJoints = { 34, 34, },
			geoAttributes = { "VEHICLE" },
		},
		
		
		"PLG_STRYKER_CAMERA_BEHAVIOR",
		TppStrykerCameraBehaviorPlugin
		{
			name						= "CameraBehavior",
			attachPointNameForAround	= { "SKL_170_WHEELL4", "SKL_180_WHEELR4", },
			basePosOffsetForAround		= Vector3( 0.0, 0.2, 2.75 ),
		},
		
		
		"PLG_STRYKER_BOUNDER",
		ChBounderPlugin{
			name			= "Bounder",
			sceneName		= "MainScene",
			bounders		= {
					{ worldName = "", partsName = "HumanBounder" },
			},
			isEnable		= true,		
			isSleepStart	= true,		
		},
	
		
		"PLG_STRYKER_EFFECT",
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "MainBody",
		},
		
		
		"PLG_STRYKER_NEW_INVENTORY",
		TppMechaInventoryPlugin {
			name			= "NewInventory",
		},
		
		
		"PLG_STRYKER_ACTION_ROOT",
		ChActionRootPlugin {
			name = "ActionRoot",
		},
		
		
		"PLG_STRYKER_BASIC_ACTION",
		TppVehicleBasicActionPlugin {
			name			= "TppStrykerBasicAction",	
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "NormalAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			
			
			
			
			
			isSleepStart = true,
		},
		
		
		
		"PLG_STRYKER_DRIVING_ACTION",
		TppPlayerDrivingStrykerActionPlugin {
			name			= "DrivingAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			
			priority		= "DrivingAction",
			exclusiveGroups = { TppPluginExclusiveGroup.Driving },
			isSleepStart = true,
		},
		
		
		"PLG_STRYKER_HIT_ACTION",
		TppVehicleHitActionPlugin{
			name			= "HitAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			priority		= "NormalAction",
			bodyAttackGroup = { "ENEMY", "OBJECT", "FRIEND" },
			velocityThresholdHit = 20.0,
			velocityThresholdPush = 5.0,
			isSleepStart = true,
		},

		
		"PLG_STRYKER_TRACK_TURRET",
		TppStrykerTurretTrackCameraActionPlugin {
			name			= "TrackTurret",
			bodyPlugin		= "MainBody",
			parent			= "ActionRoot",
			isSleepStart	= true,		
		},
		
		
		"PLG_STRYKER_ATTACK_ACTION",
		TppStrykerAttackActionPlugin {
			name			= "AttackAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			priority		= "NormalAction",
			isSleepStart	= true,		
		},
		
		
		
		"PLG_STRYKER_SHARED_INFO_STORAGE",
		ChSharedInfoStoragePlugin {
			name = "SharedInfoStorage",
			isSleepStart	= true,		
		},
		
		
		"PLG_STRYKER_NAVIGATION",
		TppVehicleNavigationPlugin{
			name		= "Navigation",
			sceneName	= "MainScene",
			worldName	= "",
			
			typeName		 = "SteeringController",
			radius			 = 2,
			minimumTurningRadius = 5,
			steeringMargin   = 3.5,
			attribute		 = {0,0,0,0},
			
		},
	}














































































	chara:AddPlugins{

		"PLG_STRYKER_SQUAD",
		TppSquadMemberPlugin{
			name			= "Squad",
			isSleepStart	= true,		
		},
		
		
		"PLG_ENEMY_STRYKER_BASIC_ACTION",
		TppEnemyStrykerBasicActionPlugin {
			name			= "EnemyBasicAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "EnemyBasicAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.EnemyBasic },
			isSleepStart	= true,		
		},
		
		
		"PLG_ENEMY_STRYKER_TURRET_ACTION",
		TppEnemyStrykerTurretActionPlugin {
			name			= "TurretAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "TurretAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Turret },
			isSleepStart	= true,		
		},
		
		
		"PLG_ENEMY_STRYKER_MACHINEGUN_ACTION",
		TppEnemyStrykerMachinegunActionPlugin{
			name			= "MachinegunAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "MachinegunAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Machinegun },
			isSleepStart	= true,		
		},
		
		
		"PLG_ENEMY_STRYKER_DEAD_ACTION",
		TppEnemyStrykerDeadActionPlugin {
			name			= "DeadAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "DeadAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Turret, TppPluginExclusiveGroup.Machinegun },
			isSleepStart	= true,
		},

		"PLG_STRYKER_NPC_DRIVING_ACTION",
		TppNpcDrivingActionPlugin {
			name			= "NpcDrivingAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			priority		= "DrivingAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Driving },
			vpc	= "vpc",
			vdp = "vdp",
			isSleepStart	= true,		
		},
		
		"PLG_STRYKER_PASSENGER_ADJUST",
		TppVehiclePassengerAdjustPlugin{
			name			= "PassengerAdjust",
			isSleepStart	= true,
		},
		
		"PLG_STRYKER_FALL_DAMAGE_ACTION",
		TppVehicleFallDamageActionPlugin{
			name			= "FallDamageAction",
			bodyPlugin		= "MainBody",
			parent			= "ActionRoot",
			isSleepStart	= true,
		},
		
		"PLG_STRYKER_CRASH_DAMAGE_ACTION",
		TppVehicleCrashDamageActionPlugin{
			name			= "CrashDamageAction",
			bodyPlugin		= "MainBody",
			parent			= "ActionRoot",
			minRelativeSpeed = 4.0,
			maxRelativeSpeed = 14.0,
			isSleepStart	= true,
		},
	}


















end,

OnRealize = function( chara )
end,

OnReset = function( chara )
end,

OnRelease = function( chara )
end,
















}
