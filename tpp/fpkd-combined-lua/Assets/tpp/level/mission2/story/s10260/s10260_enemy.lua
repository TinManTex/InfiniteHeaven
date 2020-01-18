local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}






this.soldierPowerSettings = {
	sol_infantry_0006 = { "SNIPER" },
	sol_infantry_0007 = { "SNIPER" },

	sol_infantry_riders_0000 = { "SOFT_ARMOR","SHIELD", },
	sol_infantry_riders_0001 = { "SOFT_ARMOR", },
	sol_infantry_riders_0002 = { "SOFT_ARMOR","SHOTGUN", },
	sol_infantry_riders_0003 = { "SOFT_ARMOR","SHIELD", },
	sol_infantry_riders_0004 = { "SOFT_ARMOR","MG", },
	sol_infantry_riders_0005 = { "SOFT_ARMOR","SMG", },

}


this.soldierDefine = {
	
	

	afgh_remnants_cp = {
		
		"sol_infantry_0100",
		"sol_infantry_0101",
		"sol_infantry_0102",
		"sol_infantry_0103",
		"sol_infantry_0104",
		"sol_infantry_0105",

		
		"sol_tank_0000",
		"sol_tank_0001",
		"sol_tank_0002",
		"sol_tank_0003",
		"sol_tank_0004",
		"sol_tank_0005",
		"sol_tank_0006",
		"sol_tank_0007",
		"sol_tank_0008",
		"sol_tank_0009",
		"sol_tank_0010",
		"sol_tank_0011",
		"sol_tank_0012",
		"sol_tank_0013",

		
		
		"sol_infantry_0000",
		"sol_infantry_0001",
		"sol_infantry_0002",
		"sol_infantry_0003",
		
		"sol_infantry_0004",
		"sol_infantry_0005",
		"sol_infantry_0006",
		"sol_infantry_0007",
		
		
		"sol_infantry_riders_0000",
		"sol_infantry_riders_0001",
		"sol_infantry_riders_0002",
		"sol_infantry_riders_0003",
		"sol_infantry_riders_0004",
		"sol_infantry_riders_0005",

		"sol_infantry_0008",
		"sol_infantry_0009",
		"sol_infantry_0010",
		"sol_infantry_0011",
		"sol_infantry_0012",
		"sol_infantry_0013",
		"sol_infantry_0014",
		"sol_infantry_0015",
		"sol_infantry_0016",
		"sol_infantry_0017",
		"sol_infantry_0018",
		"sol_infantry_0019",
		"sol_infantry_0020",
	},

}





this.WAVE_00 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0001", },
	},

	enemyList = {
		{ name = "sol_tank_0001", route = "route0001", },
	},

	VehicleRelation = {
		{ enemyId = "sol_tank_0001",  vehicleId = "TppVehicleLocator0001", },
	},
}

this.WAVE_01 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0000", },
		{ id = "Respawn", name = "TppVehicleLocator0002", },
	},
	
	enemyList = {
		{ name = "sol_tank_0000", route = "route0000", },
		{ name = "sol_tank_0002", route = "route0002", },
		{ name = "sol_infantry_0002", },
		{ name = "sol_infantry_0003", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0000",  vehicleId = "TppVehicleLocator0000", },
		{ enemyId = "sol_tank_0002",  vehicleId = "TppVehicleLocator0002", },
	},
}


this.WAVE_02 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0003", },
		{ id = "Respawn", name = "TppVehicleLocator0004", },
	},
	
	enemyList = {
		{ name = "sol_tank_0003", route = "route0003", },
		{ name = "sol_tank_0004", route = "route0004", },
		

		{ name = "sol_infantry_0004", },
		{ name = "sol_infantry_0005", },

	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0003",  vehicleId = "TppVehicleLocator0003", },
		{ enemyId = "sol_tank_0004",  vehicleId = "TppVehicleLocator0004", },
	},
}

this.WAVE_03 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0005", },
	},
	
	enemyList = {
		{ name = "sol_tank_0005", route = "route0005", },

		{ name = "sol_infantry_0006", },
		{ name = "sol_infantry_0007", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0005",  vehicleId = "TppVehicleLocator0005", },
	},
	
}



this.WAVE_04 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0006", },
		{ id = "Respawn", name = "TppVehicleLocator0007", },
	},
	
	enemyList = {
		{ name = "sol_tank_0006", route = "route0006", },
		{ name = "sol_tank_0007", route = "route0007", },
		
		{ name = "sol_infantry_0008", },
		{ name = "sol_infantry_0009", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0006",  vehicleId = "TppVehicleLocator0006", },
		{ enemyId = "sol_tank_0007",  vehicleId = "TppVehicleLocator0007", },
	},
}

this.WAVE_05 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0008", },
	},
	
	enemyList = {
		{ name = "sol_tank_0008", route = "route0008", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0008",  vehicleId = "TppVehicleLocator0008", },
	},
}


this.WAVE_06 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0009", },
		{ id = "Respawn", name = "TppVehicleLocator0010", },
		{ id = "Respawn", name = "TppVehicleLocator0011", },
	},
	
	enemyList = {
		{ name = "sol_tank_0009", route = "route0009", },
		{ name = "sol_tank_0010", route = "route0010", },
		{ name = "sol_tank_0011", route = "route0011", },
		

		{ name = "sol_infantry_0010", },
		{ name = "sol_infantry_0011", },
		{ name = "sol_infantry_0012", },
		{ name = "sol_infantry_0013", },
		{ name = "sol_infantry_0014", },

	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0009",  vehicleId = "TppVehicleLocator0009", },
		{ enemyId = "sol_tank_0010",  vehicleId = "TppVehicleLocator0010", },
		{ enemyId = "sol_tank_0011",  vehicleId = "TppVehicleLocator0011", },
	},
}



this.WAVE_07 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0012", },
	},
	
	enemyList = {
		{ name = "sol_tank_0012", route = "route0012", },
		{ name = "sol_infantry_0015", },
		{ name = "sol_infantry_0016", },
		{ name = "sol_infantry_0017", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0012",  vehicleId = "TppVehicleLocator0012", },
	},
	
}

this.WAVE_08 = {
	vehicleList = {
		{ id = "Respawn", name = "TppVehicleLocator0013", },
	},
	
	enemyList = {
		{ name = "sol_tank_0013", route = "route0013", },
		{ name = "sol_infantry_0018", },
		{ name = "sol_infantry_0019", },
		{ name = "sol_infantry_0020", },
	},
	
	VehicleRelation = {
		{ enemyId = "sol_tank_0013",  vehicleId = "TppVehicleLocator0013", },
	},
	
}


this.despawnList = {
	
	{ id = "Despawn", locator = "TppVehicleLocator0000", name = "TppVehicleLocator0000", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, },
	{ id = "Despawn", locator = "TppVehicleLocator0001", name = "TppVehicleLocator0001", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, },
	{ id = "Despawn", locator = "TppVehicleLocator0002", name = "TppVehicleLocator0002", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, },
	
	{ id = "Despawn", locator = "TppVehicleLocator0003", name = "TppVehicleLocator0003", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, },
	{ id = "Despawn", locator = "TppVehicleLocator0004", name = "TppVehicleLocator0004", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, },
	{ id = "Despawn", locator = "TppVehicleLocator0005", name = "TppVehicleLocator0005", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, },
	
	{ id = "Despawn", locator = "TppVehicleLocator0006", name = "TppVehicleLocator0006", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, },
	{ id = "Despawn", locator = "TppVehicleLocator0007", name = "TppVehicleLocator0007", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY,},
	{ id = "Despawn", locator = "TppVehicleLocator0008", name = "TppVehicleLocator0008", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY,},
	
	{ id = "Despawn", locator = "TppVehicleLocator0009", name = "TppVehicleLocator0009", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY, },
	{ id = "Despawn", locator = "TppVehicleLocator0010", name = "TppVehicleLocator0010", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY,},
	{ id = "Despawn", locator = "TppVehicleLocator0011", name = "TppVehicleLocator0011", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY,},
	{ id = "Despawn", locator = "TppVehicleLocator0012", name = "TppVehicleLocator0012", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY, },
	{ id = "Despawn", locator = "TppVehicleLocator0013", name = "TppVehicleLocator0013", type = Vehicle.type.EASTERN_TRACKED_TANK, subType = Vehicle.subType.NONE, class = Vehicle.class.DARK_GRAY, },
}

this.TaskVehicles = {
	"TppVehicleLocator0000",
	"TppVehicleLocator0001",
	"TppVehicleLocator0002",
	"TppVehicleLocator0003",
	"TppVehicleLocator0004",
	"TppVehicleLocator0005",
	"TppVehicleLocator0006",
	"TppVehicleLocator0007",
	"TppVehicleLocator0008",
	"TppVehicleLocator0009",
	"TppVehicleLocator0010",
	"TppVehicleLocator0011",
	"TppVehicleLocator0012",
	"TppVehicleLocator0013",
}

this.vehicleDefine = {
	instanceCount   = 20,
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.DespawnVehicles( this.despawnList )
end









this.routeSets = {
	
	afgh_remnants_cp = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0002",
				"rts_sol_infantry_0002",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0002",
				"rts_sol_infantry_0002",
			},
			nil
		},
		caution = {
			groupA = {
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0000",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0001",
				"rts_sol_infantry_0002",
				"rts_sol_infantry_0002",
			},
			nil
		},

		hold = {
			default = {
			},
		},
		nil
	},
}





this.combatSetting = {

	afgh_remnants_cp = {
		"TppGuardTargetData0000",
		"TppCombatLocatorSetData0000",
	},
	nil

}






function this.fixRoute ( enemyId, routeId )
	TppEnemy.SetSneakRoute( enemyId, routeId )
	TppEnemy.SetCautionRoute( enemyId, routeId )
	TppEnemy.SetAlertRoute( enemyId, routeId )
end


function this.DisableBossEnemies()
	for i, enemyId in ipairs( this.soldierDefine.afgh_remnants_cp ) do
		TppEnemy.SetDisable( enemyId )
	end
end

function this.EnemyHeliSetCp ( cpName )
	local gameObjectId = GameObject.GetGameObjectId( "EnemyHeli" )
	GameObject.SendCommand(gameObjectId, { id="SetCommandPost", cp = cpName })
end

function this.RegisterOnRecoveredVehicle()
	for i, vehicleId in ipairs( this.TaskVehicles ) do
		TppEnemy.RegistHoldRecoveredState( vehicleId )
	end
end

function this.SetIgnoreReinforce()
	local cpId = { type="TppCommandPost2" } 
	local command = { id = "SetIgnoreReinforce" }
	GameObject.SendCommand( cpId, command )
end







this.InitEnemy = function ()
end




this.SetUpEnemy = function ()
	this.DisableBossEnemies()
	this.SetIgnoreReinforce()

	TppEnemy.RegisterCombatSetting( this.combatSetting )
	this.EnemyHeliSetCp ( "afgh_remnants_cp" )
	TppBuddyService.SetVarsQuietWeaponType(4)
	TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK )
	this.RegisterOnRecoveredVehicle()
end


this.OnLoad = function ()
	Fox.Log("*** s10260 onload ***")
end






this.CreateWave = function( params )
	Fox.Log("*** CreateWave ***")
	if params.waveList then
		
        for i, command in ipairs( params.waveList.vehicleList ) do
			TppEnemy.RespawnVehicle( command )
        end
        
		
		for i, enemyTable in ipairs( params.waveList.enemyList ) do
			TppEnemy.SetEnable( enemyTable.name )
			if enemyTable.route then
				this.fixRoute( enemyTable.name, enemyTable.route )
			end
		end
		
		
		for i, vehicleTable in ipairs( params.waveList.VehicleRelation ) do
			local gameObjectId = GameObject.GetGameObjectId( vehicleTable.enemyId )
			local vehicleId = GameObject.GetGameObjectId( vehicleTable.vehicleId )
			local command = { id = "SetRelativeVehicle", targetId = vehicleId, rideFromBeginning = true }
			GameObject.SendCommand( gameObjectId, command )
			Fox.Log("SetRelativeVehicle")
		end
	end
end



this.fleeEnemies = function()
	local fleeEnemies = {
		"sol_infantry_0000",
		"sol_infantry_0001",
		"sol_infantry_0002",
		"sol_infantry_0003",
		"sol_infantry_0004",
	}

	for i, enemyId in ipairs( fleeEnemies ) do
		TppEnemy.SetAlertRoute( enemyId, "route_flee" )
	end
end



return this
