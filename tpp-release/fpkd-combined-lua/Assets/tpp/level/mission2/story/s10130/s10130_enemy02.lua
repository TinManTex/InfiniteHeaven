local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}

local HELI_ROUTE_PATROL = "rts_s10130_heli_0000"


this.VEHICLE_NAME = {
	WEST_WAV01						= "veh_guard01_0000",				
}


this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = this.VEHICLE_NAME.WEST_WAV01,		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,	subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON, class = Vehicle.class.DARK_GRAY,},
}
this.VEHICLE_SPAWN_LIST_HARD = {
	{ id = "Spawn", locator = this.VEHICLE_NAME.WEST_WAV01,		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,	subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON, class = Vehicle.class.OXIDE_RED,},
}

this.vehicleDefine = {
	instanceCount = #this.VEHICLE_SPAWN_LIST,
}





this.soldierDefine = {
	
	mafr_lab_cp = {
		
		"sol_lab_0000",
		"sol_lab_0001",
		"sol_lab_0002",
		"sol_lab_0003",
		"sol_lab_0004",
		"sol_lab_0005",
		"sol_lab_0006",
		"sol_lab_0007",
		"sol_lab_0008",
		"sol_lab_0009",
		"sol_lab_0010",
		"sol_lab_0011",
		nil
	},
	mafr_lab_w_cp = {
		
		"sol_lab_0012",
		"sol_lab_0013",
		"sol_lab_0014",
		"sol_lab_0015",
		"sol_lab_0016",
		"sol_lab_0017",
		"sol_lab_0018",
		"sol_lab_0019",
		"sol_lab_0020",
		"sol_lab_0021",
		"sol_lab_0022",
		"sol_lab_0023",
		nil
	},
	mafr_lab_s_cp = {
		
		"sol_lab_0024",
		"sol_lab_0025",
		"sol_lab_0026",
		"sol_lab_0027",
		"sol_lab_0028",
		"sol_lab_0029",
		"sol_lab_0030",
		"sol_lab_0031",
		"sol_lab_0032",
		"sol_lab_0033",
		"sol_lab_0034",
		"sol_lab_0035",
		nil
	},
	nil
}


this.soldierSubTypes = {
	
	PF_B = {
		this.soldierDefine.mafr_lab_w_cp,	
		this.soldierDefine.mafr_lab_s_cp,	
	},
}


this.taskTargetList = {
	"veh_guard01_0000",
}





this.routeSets = {

	
	mafr_lab_cp			= { USE_COMMON_ROUTE_SETS = true,	},

	mafr_lab_w_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
			},
		},
		caution = {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
			},
		},
		hold = {
			
			
			default = {
			},
		},
		sleep = {
			default = {
			},
		},
		nil
	},
	mafr_lab_s_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
			},
		},
		caution = {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
			},
		},
		hold = {
			
			
			default = {
			},
		},
		sleep = {
			default = {
			},
		},
		nil
	},
	nil
}





this.combatSetting = {
	mafr_lab_cp = {
		"gts_lab_0000",
		"css_lab_0000",
	},
	mafr_lab_w_cp = {
		"gts_lab_w_0000",
		"css_lab_w_0000",
	},
	mafr_lab_s_cp = {
		"gts_lab_s_0000",
		"css_lab_s_0000",
	},
	nil
}




this.cpIdList = {
	"mafr_lab_cp",
	"mafr_lab_w_cp",
	"mafr_lab_s_cp",
	nil
}




this.enemyRouteReload = {
	{ soldierName = "sol_lab_0000",routeName="rt_lab_c_0000" },
	{ soldierName = "sol_lab_0001",routeName="rt_lab_c_0001" },
	{ soldierName = "sol_lab_0002",routeName="rt_lab_c_0002" },
	{ soldierName = "sol_lab_0003",routeName="rt_lab_c_0004" },
	{ soldierName = "sol_lab_0004",routeName="rt_lab_c_0005" },
	{ soldierName = "sol_lab_0005",routeName="rt_lab_c_0006" },
	{ soldierName = "sol_lab_0006",routeName="rt_lab_c_0000" },
	{ soldierName = "sol_lab_0007",routeName="rt_lab_c_0001" },
	{ soldierName = "sol_lab_0008",routeName="rt_lab_c_0003" },
	{ soldierName = "sol_lab_0009",routeName="rt_lab_c_0004" },
	{ soldierName = "sol_lab_0010",routeName="rt_lab_c_0005" },
	{ soldierName = "sol_lab_0011",routeName="rt_lab_c_0007" },
	{ soldierName = "sol_lab_0012",routeName="rts_lab_w_0000" },
	{ soldierName = "sol_lab_0013",routeName="rts_lab_w_0001" },
	{ soldierName = "sol_lab_0014",routeName="rts_lab_w_0002" },
	{ soldierName = "sol_lab_0015",routeName="rts_lab_w_0003" },
	{ soldierName = "sol_lab_0016",routeName="rts_lab_w_0004" },
	{ soldierName = "sol_lab_0017",routeName="rts_lab_w_0005" },
	{ soldierName = "sol_lab_0018",routeName="rts_lab_w_0006" },
	{ soldierName = "sol_lab_0019",routeName="rts_lab_w_0001" },
	{ soldierName = "sol_lab_0020",routeName="rts_lab_w_0002" },
	{ soldierName = "sol_lab_0021",routeName="rts_lab_w_0003" },
	{ soldierName = "sol_lab_0022",routeName="rts_lab_w_0004" },
	{ soldierName = "sol_lab_0023",routeName="rts_lab_w_0005" },
	{ soldierName = "sol_lab_0024",routeName="rts_lab_s_0000" },
	{ soldierName = "sol_lab_0025",routeName="rts_lab_s_0001" },
	{ soldierName = "sol_lab_0026",routeName="rts_lab_s_0002" },
	{ soldierName = "sol_lab_0027",routeName="rts_lab_s_0003" },
	{ soldierName = "sol_lab_0028",routeName="rts_lab_s_0004" },
	{ soldierName = "sol_lab_0029",routeName="rts_lab_s_0005" },
	{ soldierName = "sol_lab_0030",routeName="rts_lab_s_0000" },
	{ soldierName = "sol_lab_0031",routeName="rts_lab_s_0001" },
	{ soldierName = "sol_lab_0032",routeName="rts_lab_s_0002" },
	{ soldierName = "sol_lab_0033",routeName="rts_lab_s_0003" },
	{ soldierName = "sol_lab_0034",routeName="rts_lab_s_0004" },
	{ soldierName = "sol_lab_0035",routeName="rts_lab_s_0005" },
	nil
}






this.interrogation = {
}

this.useGeneInter = {
	
	mafr_lab_cp = true,
	mafr_lab_w_cp = true,
	mafr_lab_s_cp = true,
	nil
}




this.cpGroups = {
	group_Area5 = {
		
		"mafr_lab_cp",
		

		
		
		"mafr_lab_w_cp",
		"mafr_lab_s_cp",
	},
}




this.SpawnVehicleOnInitialize = function()
	Fox.Log("*** SetVehicleSpawn ***")
	local missionID = TppMission.GetMissionID()
	
	if	( missionID == 11130 )	then 
		TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST_HARD )
	else
		TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
	end
	
end


this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	local obSetCommand = { id = "SetOuterBaseCp" }
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_lab_w_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_lab_s_cp" ) , obSetCommand )

	
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	this.EnemyHeliAround()
	
	
	local missionID = TppMission.GetMissionID()
	if	( missionID == 11130 )	then 
		TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.RED )
	else
		TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK )
	end

	
	this.SetRelativeVehicle()

	
	this.RegistHoldRecoveredStateForMissionTask( this.taskTargetList )

	
	TppEnemy.SetRescueTargets( { "CodeTalker" } )

	
	this.FormationLine()

end


this.OnLoad = function ()
	Fox.Log("*** s10130 onload ***")
end





function this.ResetPositionEnemy01()

	for name, group in pairs( this.soldierDefine ) do
		for i, enemyName in ipairs( group ) do
			local gameObjectId = GameObject.GetGameObjectId( enemyName )
			local command = { id="SetEnabled", enabled=false }
			GameObject.SendCommand( gameObjectId, command )
		end
	end

	TppEnemy.ChangeRouteSets( this.routeSets01 )

end


function this.ResetPositionEnemy02()

	for name, group in pairs( this.soldierDefine ) do
		for i, enemyName in ipairs( group ) do
			local gameObjectId = GameObject.GetGameObjectId( enemyName )
			local command = { id="SetEnabled", enabled=true }
			GameObject.SendCommand( gameObjectId, command )
		end
	end

end


function this.EnemyReloadResetPosition()
	for i, name in pairs( this.enemyRouteReload ) do
		
		local gameObjectId00 =  GameObject.GetGameObjectId( name.soldierName )
		local command00 = { id="SetEnabled", enabled=false }
		GameObject.SendCommand( gameObjectId00, command00 )

		
		TppEnemy.SetSneakRoute( name.soldierName, name.routeName )
		TppEnemy.SetCautionRoute( name.soldierName, name.routeName )

		
		local gameObjectId01 =  GameObject.GetGameObjectId( name.soldierName )
		local command01 = { id="SetEnabled", enabled=true }


	end
end

function this.EnableEnemy()
	for i, name in pairs( this.enemyRouteReload ) do
		
		local gameObjectId01 =  GameObject.GetGameObjectId( name.soldierName )
		local command01 = { id="SetEnabled", enabled=true }
		GameObject.SendCommand( gameObjectId01, command01 )
	end
end


this.FormationLine = function()
	local j = 0
	local gameObjectId
	local command = { id="SetForceFormationLine", enable=true }

	for name, group in pairs( this.soldierDefine ) do
		j = j + 1
		for i = 1, #group do
			local EnemyTargetName = group[i]
			gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", EnemyTargetName )
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end


function this.UnlockedCodeTalker()

	local locatorName = "CodeTalker"
	local gameObjectType = "TppCodeTalker2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id = "SetHostage2Flag",
		
		flag = "unlocked",            
		on = true,
	}
	GameObject.SendCommand( gameObjectId, command )

end



this.SetEnabledFlagToEnemyHeli = function(flag)
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="SetEnabled", 	enabled=flag })
end


this.EnemyHeliSetRoute = function(routeId)
	Fox.Log("change route Enemy Heli "..routeId )
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="RequestRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetCommandPost",	cp="mafr_lab_cp" })
end


this.EnemyHeliAround = function()
	this.EnemyHeliSetRoute(HELI_ROUTE_PATROL)
end


this.SetVehicleSpawn = function( spawnList )
	Fox.Log("*** SetVehicleSpawn ***")
	for i, command in ipairs( spawnList ) do
		GameObject.SendCommand( { type="TppVehicle2", }, command )
	end
end


this.SetRelativeVehicle = function()
	Fox.Log("*** SetVehicleSpawn ***")
	local targetDriverId_01		= GameObject.GetGameObjectId("TppSoldier2", "sol_lab_0012" )
	local targetVehicleId_01	= GameObject.GetGameObjectId("TppVehicle2", "veh_guard01_0000" )
	local command_target01 	= { id="SetRelativeVehicle", targetId = targetVehicleId_01	, rideFromBeginning = true }
	GameObject.SendCommand( targetDriverId_01	, command_target01 )
end


this.RegistHoldRecoveredStateForMissionTask = function( taskTargetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(taskTargetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end




return this
