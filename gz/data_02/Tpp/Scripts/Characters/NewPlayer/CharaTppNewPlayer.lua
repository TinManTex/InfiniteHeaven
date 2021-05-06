


CharaTppNewPlayer = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
	"Nav",
	"Ui",
	"GroupBehavior",
},

pluginIndexEnumInfoName = "TppPlayerPluginDefine",




AddTppPlugins = function( chara )

	
	
	

	chara:AddPlugins {
		
		"PLG_TIME_CIGARETTE_CONTROL_ACTION",
		TppTimeCigaretteActionPlugin{
			name			= "TimeCigaretteActionPlugin",
			bodyPlugin		= "MainBody",
			parent			= "ActionRoot",
			layerName			= "Lower",
			priority			= "CigaretteAction",
			exclusiveGroups		= { TppPluginExclusiveGroup.Lower },
			
			isSleepStart	= true,
			disableActions		= { "DIS_ACT_MB_TERMINAL", "DIS_ACT_BINOCLE" },
		},

		
		"PLG_FULTON_ACTION",
		TppFultonActionPlugin{
			name			= "FultonAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppFulton.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "FultonAction",

			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_ATTACK", "DIS_ACT_UPPER", "DIS_ACT_BINOCLE", "DIS_ACT_MB_TERMINAL", "DIS_ACT_CQC" },
		},

		
		"PLG_COUNTER_ACTION",
		TppCounterActionPlugin{
			name			= "CounterAction",
			script			= "Tpp/Scripts/Characters/NewPlayer/Actions/ActionTppNewPlayerCounter.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "CounterAction",
			
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_CQC", "DIS_ACT_BINOCLE", "DIS_ACT_MB_TERMINAL", "DIS_ACT_BEHIND", "DIS_ACT_CARRY", "DIS_ACT_CLIMB", "DIS_ACT_FULTON", "DIS_ACT_LADDER", "DIS_ACT_JUMP", "DIS_ACT_PIPE", "DIS_ACT_UPPER", "DIS_ACT_FENCE", "DIS_ACT_STEPON_HAND", "DIS_ACT_WALL", "DIS_ACT_CALL" },
		},

		
		"PLG_CURTAIN",
		TppCurtainActionPlugin{
			name			= "CurtainAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			isAlwaysAwake	= true,
		},

		
		"PLG_SET_PLAY_ACTION",
		TppSetPlayActionPlugin{
			name			= "SetPlayAction",
			script			= "Tpp/Scripts/Characters/NewPlayer/Actions/ActionTppNewPlayerSetPlay.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "SetPlayAction",
			target			= "TargetSetPlayDefense",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_CQC", "DIS_ACT_BINOCLE", "DIS_ACT_MB_TERMINAL", "DIS_ACT_BEHIND", "DIS_ACT_CARRY", "DIS_ACT_CLIMB", "DIS_ACT_FULTON", "DIS_ACT_LADDER", "DIS_ACT_JUMP", "DIS_ACT_PIPE", "DIS_ACT_UPPER", "DIS_ACT_FENCE", "DIS_ACT_STEPON_HAND", "DIS_ACT_WALL", "DIS_ACT_CALL" },
		},

		
		"PLG_RIDE_HORSE_BASIC_ACTION",
		TppPlayerRideHorseBasicActionPlugin {
			name			= "RideHorseAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppPlayerRideHorse.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= { "Lower", "Upper", "UpperDiff", "Head" },
			priority		= "RideHorseAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
			requestHorseTargetGroup	= { "FRIEND" },
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_WALL", "DIS_ACT_FALL_DAMAGE" },
		},

		
		"PLG_RIDE_MGM_ACTION",
		TppRideMgmActionPlugin {
			name			= "RideMgmAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppPlayerRideMgm.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "RideMgmAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Carry },
			isSleepStart	= true,
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_WALL", "DIS_ACT_FALL_DAMAGE" },
		},

		"PLG_RIDE_MGM_ADJUST",
		TppRideMgmAdjustPlugin {
			name			= "RideMgmAdjust",
			priority		= "RideMgmAction",
			isAlwaysAwake	= true,
		},

		
		"PLG_CLIMB_PATH_ACTION",
		TppClimbPathActionPlugin {
			name			= "ClimbPathAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppClimbPath.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "NewEludeByPathAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Carry },
			isSleepStart	= true,
			searchRadius		= 1.5,
			checkCurrentRadius	= 1.5,
			needTag				= {},
			includeTag			= { "Climb" },
		},

		
		"PLG_PIPE_ACTION",
		TppPlayerPipeActionPlugin {
			name			= "PipeAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "PipeAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Carry },
			isSleepStart	= true,
			searchRadius		= 2.5,
			checkCurrentRadius	= 2.5,
			needTag				= {},
			includeTag			= { "Pipe" },
		},

		
		"PLG_THREAT_SEARCH",
		TppThreatSearchPlugin{
			name			= "ThreatSearch",
			detectThreshold	= 1,
		},

	}

if DEBUG then
	chara:AddPlugins {
		
		"PLG_RIDE_CHARACTER",
		TppRideCharacterActionPlugin {
			name			= "RideCharacterAction",
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			layerName		= "Lower",
			priority		= "RideCharacterAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
			attachPoint		= { "CNP_ppos_a", "CNP_ppos_b", "CNP_ppos_c", },
			disableActionDefineName = "TppPlayerDisableActionDefine",
			disableActions		= { "DIS_ACT_WALL", "DIS_ACT_FALL_DAMAGE" },
		},
	}
end

end,







ViewControl  = function( chara )

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local control = plgBody:GetControl()
	local pos = plgBody:GetControlPosition()
	local vecRot
	local vecTurn

	vecRot = plgBody:GetControlRotation():Rotate( Vector3( 0, 0, 1 ) )
	vecTurn = plgBody:GetControlTurnAsQuat():Rotate( Vector3( 0, 0, 1 ) )

	
	GrxDebug.Sphere {
		center	= pos,
		radius	= control:GetRadius(),
		color	= "yellow",
		life	= 1,
	}
	
	GrxDebug.Arrow {
		from	= pos,
		to		= ( pos + vecRot ),
		color	= "green",
		life	= 1,
	}
	
	GrxDebug.Arrow {
		from	= pos,
		to		= ( pos + vecTurn ),
		color	= "blue",
		life	= 1,
	}
end,


ViewAnimControl  = function( chara )

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	plgBody:DebugDisplayAnimControl()

end,


ViewMotionPoint = function( chara, mtpName )

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local isValid, mtpMatrix = plgBody:GetValidMotionPointMatrix( mtpName )
	if isValid then
		
		GrxDebug.Sphere {
			center	= mtpMatrix,
			radius	= 0.1,
			color	= "magenta",
			life	= 1,
		}
		GrxDebug.Matrix {
			matrix	=mtpMatrix,		
			size	=0.5,			
			life	=1,			
		}

		GrxDebug.Print3D {
			world  = mtpMatrix,
			color = "white",
			back = true,
			args  = { plgBody:GetMotionPointLayer( mtpName ) }
		}
	else
		
	end

end,


PrintPadNo  = function()

	local padMapping = PadMapping:GetInstance()
	local pad0No = padMapping:GetPad0LogicalNum()
	local pad1No = padMapping:GetPad1LogicalNum()
	local pad0Color = Color(0.7,0.7,0.7,1)
	local pad1Color = Color(0.7,0.7,0.7,1)
	
	if pad0No == 0 then
		pad0Color = Color(1,1,1,1)
	end
	
	if pad1No == 0 and pad0No ~= 0 then
		pad1Color = Color(1,1,1,1)
	end
	GrxDebug.Print2D {
		x=40, y=665,
		size = 10,
		color=pad0Color,
		args={ "Pad 0 No : ", pad0No }
	}
	GrxDebug.Print2D {
		x=40, y=680,
		size = 10,
		color=pad1Color,
		args={ "Pad 1 No : ", pad1No }
	}

end,

}
