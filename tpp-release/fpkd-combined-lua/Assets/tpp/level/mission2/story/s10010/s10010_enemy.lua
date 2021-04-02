local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.ENTRANCE_ENEMY_LIST = {
	"sol_p21_010500_0006",
	"sol_p21_010500_0007",
	"sol_p21_010500_0008",
	"sol_p21_010500_0009",
	"sol_p21_010500_0010",
	"sol_p21_010500_0011",
}
this.ENTRANCE_ENEMY_LIST2 = {
	"sol_p21_010500_0000",
	"sol_p21_010500_0001",
	"sol_p21_010500_0002",
	"sol_p21_010500_0003",
	"sol_p21_010500_0004",
	"sol_p21_010500_0005",
}


this.soldierDefine = {
	cypr_cp = {
		"sol_p21_010310_0000",
		"sol_p21_010310_0001",
		"sol_p21_010310_0002",
		"sol_p21_010340_0000",
		"sol_p21_010370_0000",
		"sol_p21_010370_0001",
		"sol_p21_010380_0000",
		"sol_p21_010380_0001",
		"sol_p21_010380_0002",
		"sol_p21_010380_0003",
		"sol_p21_010420_0000",
		"sol_p21_010420_0001",
		"sol_p21_010440_0000",
		"sol_p21_010440_0001",
		"sol_p21_010440_0002",
		"sol_p21_010440_0003",
		"sol_p21_010490_0000",
		"sol_p21_010490_0001",
		"sol_p21_010490_0002",
		"sol_p21_010490_0003",
		"sol_p21_010520_0000",
		"sol_p21_010520_0001",
		"sol_p21_010520_0002",
		"sol_p21_010520_0003",
		"sol_p21_010520_0004",
		"sol_p21_010520_0005",
		nil
	},
	nil
}

for i, enemyName in ipairs( this.ENTRANCE_ENEMY_LIST ) do
	table.insert( this.soldierDefine.cypr_cp, enemyName )
end
for i, enemyName in ipairs( this.ENTRANCE_ENEMY_LIST2 ) do
	table.insert( this.soldierDefine.cypr_cp, enemyName )
end


this.soldierAllowedToSwitchLightTable = {
	sol_p21_010310_0000 = true,
	sol_p21_010340_0000 = true,
	sol_p21_010370_0000 = true,
	sol_p21_010380_0000 = true,
	sol_p21_010380_0002 = true,
	sol_p21_010420_0000 = true,
	
	sol_p21_010490_0000 = true,
	
	
}

this.soldierAllowedCastShadowTable = {
	sol_p21_010310_0000 = true,
	sol_p21_010340_0000 = true,
	sol_p21_010370_0000 = true,
	sol_p21_010380_0000 = true,
	sol_p21_010380_0002 = true,
	sol_p21_010420_0000 = true,
	sol_p21_010440_0000 = true,
	sol_p21_010490_0000 = true,
}




this.soldierAllowedSuppressorTable = {
	sol_p21_010310_0000 = true,
	sol_p21_010310_0001 = true,
	sol_p21_010310_0002 = true,
	sol_p21_010340_0000 = true,
	sol_p21_010420_0000 = true,
	sol_p21_010420_0001 = true,
}

this.mobListTable = {
	doctorAndNurseList = {
		"awake_doctor",
		"dct_p21_010410_0000",
		"dct_p21_010410_0001",
		"awake_nurse",
		"nrs_p21_010360_0000",
		"nrs_p21_010410_0000",
		"nrs_p21_010410_0001",
		"nrs_p21_010410_0002",
	},
	patientList = {
		"ptn_p21_010340_0000",
		"ptn_p21_010340_0001",
		"ptn_p21_010360_0000",
		"ptn_p21_010370_0000",
		"ptn_p21_010380_0000",
		"ish_p21_010410_0000",
		"ptn_p21_010410_0000",
		"ptn_p21_010410_0001",
		"ptn_p21_010410_0002",
		"ptn_p21_010410_0003",
		"ptn_p21_010410_0004",
		"ptn_p21_010410_0005",
		"ptn_p21_010410_0006",
		"ptn_p21_010410_0007",
		"ptn_p21_010410_0008",
		"ptn_p21_010410_0009",
		"ptn_p21_010410_0010",
		"ptn_p21_010410_0011",
		"ptn_p21_010410_0012",
		"ptn_p21_010420_0000",
		"ptn_p21_010420_0001",
		"ptn_p21_010420_0002",
		"ptn_p21_010420_0003",
		"ptn_p21_010420_0004",
		"ptn_p21_010500_0000",
		"ptn_p21_010500_0001",
		"ptn_p21_010500_0002",
		"ptn_p21_010500_0003",
	}
}

this.corpseList = {
	"corpse_0000",
	"corpse_0001",
	"corpse_0002",
	"corpse_0003",
	"corpse_0004",
	"corpse_0005",
	"corpse_corridor_0000",
	"corpse_2f_0000",
	"corpse_entrance_0000",
	"corpse_entrance_0001",
	"corpse_entrance_0002",
	"corpse_entrance_0003",
	"corpse_entrance_0004",
	"corpse_entrance_0005",
	"corpse_entrance_0006",
	"corpse_entrance_0007",
	"corpse_entrance_0008",
	"corpse_entrance_0009",
	"corpse_entrance_0010",
	"corpse_entrance_0011",
}

this.mobFovaTable = {
	dct_p21_010410_0000 = { bodyId = 348, },
	dct_p21_010410_0001 = { bodyId = 349, },
	nrs_p21_010360_0000 = { bodyId = 340, },
	nrs_p21_010410_0000 = { bodyId = 341, },
	nrs_p21_010410_0001 = { bodyId = 342, },
	nrs_p21_010410_0002 = { bodyId = 344, },
	ptn_p21_010340_0000 = { bodyId = 333, faceId = 636, },
	ptn_p21_010340_0001 = { bodyId = 334, },
	ptn_p21_010360_0000 = { bodyId = 303, },
	ptn_p21_010370_0000 = { bodyId = 304, },
	ptn_p21_010380_0000 = { bodyId = 307, },
	ptn_p21_010410_0000 = { bodyId = 305, },
	ptn_p21_010410_0001 = { bodyId = 306, },
	ptn_p21_010410_0002 = { bodyId = 318, },
	ptn_p21_010410_0003 = { bodyId = 309, },
	ptn_p21_010410_0004 = { bodyId = 323, },
	ptn_p21_010410_0005 = { bodyId = 311, },
	ptn_p21_010410_0006 = { bodyId = 312, },
	ptn_p21_010410_0007 = { bodyId = 313, },
	ptn_p21_010410_0008 = { bodyId = 314, },
	ptn_p21_010410_0009 = { bodyId = 315, },
	ptn_p21_010410_0010 = { bodyId = 316, },
	ptn_p21_010410_0011 = { bodyId = 317, },
	ptn_p21_010410_0012 = { bodyId = 326, },
	ptn_p21_010420_0000 = { bodyId = 310, },
	ptn_p21_010420_0001 = { bodyId = 325, },
	ptn_p21_010420_0002 = { bodyId = 308, },
	ptn_p21_010420_0003 = { bodyId = 322, },
	ptn_p21_010420_0004 = { bodyId = 324, },
	ptn_p21_010500_0000 = { bodyId = 319, },
	ptn_p21_010500_0001 = { bodyId = 320, },
	ptn_p21_010500_0002 = { bodyId = 321, },
	ptn_p21_010500_0003 = { bodyId = 327, },
}

this.soldierPowerSettings = {}
for cpName, cpTable in pairs( this.soldierDefine ) do
	for j, soldierName in ipairs( cpTable ) do
		this.soldierPowerSettings[ soldierName ] = { "SMG", }
	end
end





this.routeSets = {
	
	cypr_cp = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
			},
			nil
		},
		sneak_night = {
			groupA = {
			},
			nil
		},
		caution = {
			groupA = {
			},
			nil
		},
		hold = {
			default = {
			},
		},
		nil
	},
	nil
}





this.combatSetting = {
	cypr_cp = {
	},
	nil
}




local despawnList = {
	{
		id = "Despawn",
		locator = "veh_p21_010510_0000",
		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
		subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
	},
}

this.vehicleDefine = {
	instanceCount = #despawnList,
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.DespawnVehicles( despawnList ) 
end






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	Fox.Log( "s10010_enemy.SetUpEnemy()" )

	

	
	GameObject.SendCommand( GameObject.GetGameObjectId( "cypr_cp" ), { id = "SetSkullCp", } )

	
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_p21_010440_0001" ), { id="SetEquipId", tertiary=TppEquip.EQP_WP_East_ms_010 } )

	
	for cpName, cpTable in pairs( this.soldierDefine ) do
		Fox.Log( "s10010_enemy.SetUpEnemy(): Disable All Enemies. cpName:" .. tostring( cpName ) )
		for j, enemyName in ipairs( cpTable ) do

			Fox.Log( "s10010_enemy.SetUpEnemy(): Disable All Enemies. enemyName:" .. tostring( enemyName ) )

			local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyName )
			
			GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = false, } )
			GameObject.SendCommand( gameObjectId, { id = "SetPuppet", enabled = true, } )

		end
	end

	
	local command = {
	        id = "SetHostage2Flag",
	        flag = "commonNpc",
	        on = true,
	}
	GameObject.SendCommand( GameObject.GetGameObjectId( "ishmael" ), command )

	
	for i, locatorName in ipairs( this.corpseList ) do
		GameObject.SendCommand( GameObject.GetGameObjectId( "TppCorpse", locatorName ), { id = "SetForceUnreal", enabled = true, } )
	end

	
	GameObject.SendCommand( GameObject.GetGameObjectId( "ishmael" ), { id = "SetDisableDamage", life = true, faint = true, sleep = true, } )
	TppEnemy.SetExcludeHostage( "ishmael" )

end


this.OnLoad = function()

	Fox.Log( "s10010_enemy.OnLoad()" )

	TppEquip.RequestLoadToEquipMissionBlock( { TppEquip.EQP_WP_East_ms_010 } )

end




this.IsMob = function( locatorName )

	Fox.Log( "s10010_enemy.IsMob(): locatorName:" .. tostring( locatorName ) )

	for mobListTableName, mobList in pairs( this.mobListTable ) do
		for i, mobLocatorName in ipairs( mobList ) do
			if locatorName == mobLocatorName then
				return true
			end
		end
	end

	return false

end





this.IsPatient = function( locatorName )

	Fox.Log( "s10010_enemy.IsPatient(): locatorName:" .. tostring( locatorName ) )

	for i, patientLocatorName in ipairs( this.mobListTable.patientList ) do
		if locatorName == patientLocatorName then
			return true
		end
	end

	return false

end




this.SetMobEnabled = function( locatorName, enableMob )

	Fox.Log( "s10010_enemy.SetMobEnabled(): locatorName:" .. tostring( locatorName ) )

	if not this.IsMob( locatorName ) then
		Fox.Error( "There is no Mob named " .. tostring( locatorName ) )
		return
	end

	
	
	local isPatient = this.IsPatient( locatorName )
	local identifierId
	if isPatient then
		identifierId = "s10010_s03_other_DataIdentifier"
	else
		identifierId = "s10010_s02_other_DataIdentifier"
	end
	if DataIdentifier.GetDataWithIdentifier( identifierId, identifierId ) == NULL then
		return
	end

	local gameObjectId = GameObject.GetGameObjectId( locatorName )
	if gameObjectId and gameObjectId ~= GameObject.NULL_ID then
		GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = enableMob } )
		if enableMob then
			s10010_enemy.SetUpMobFova( locatorName )
		else
			GameObject.SendCommand( gameObjectId, { id = "SetFaceBloodMode", enabled = false, } )
		end
		GameObject.SendCommand( gameObjectId, { id = "SetDisableDamage", life = true, faint = true, sleep = true, } )
		GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "disableDamageReaction", on = true, } )
	else
		Fox.Log( "s10010_enemy.SetMobEnabled(): There is no such gameObject. gameObjectId:" .. tostring( gameObjectId ) )
	end

end




this.RespawnVehicle = function( locatorName )

	Fox.Log( "s10010_enemy.RespawnVehicle()" )
	TppEnemy.RespawnVehicle{ id = "Respawn", name = locatorName, }

end




this.DespawnVehicle = function( locatorName)

	Fox.Log( "s10010_enemy.DespawnVehicle()" )
	GameObject.SendCommand( { type="TppVehicle2", }, { id = "Despawn", name = locatorName, } )

end




this.SetUpMobFova = function( locatorName )

	Fox.Log( "s10010_enemy.SetUpMobFova()" )

	local gameObjectId = GameObject.GetGameObjectId( locatorName )
	if gameObjectId and gameObjectId ~= GameObject.NULL_ID then
		Fox.Log( "s10010_enemy.SetUpMobFova(): gameObjectId:" .. tostring( gameObjectId ) )
		local fovaTable = this.mobFovaTable[ locatorName ]
		if fovaTable then
			local faceId = fovaTable.faceId
			local bodyId = fovaTable.bodyId
			if bodyId then
				Fox.Log( "s10010_enemy.SetUpMobFova(): bodyId:" .. tostring( bodyId ) )
				GameObject.SendCommand( gameObjectId, { id = "ChangeFova", faceId = faceId, bodyId = bodyId, } )
			else
				Fox.Log( "s10010_enemy.SetUpMobFova(): bodyId is invalid." )
			end
		end
	else
		Fox.Log( "s10010_enemy.SetUpMobFova(): gameObjectId is invalid." )
	end

end




this.IsAllowedToSwitch = function( locatorName )

	Fox.Log( "s10010_enemy.IsAllowedToSwitch(): locatorName:" .. tostring( locatorName ) )

	local light = not not this.soldierAllowedToSwitchLightTable[ locatorName ]	
	local castShadow = not not this.soldierAllowedCastShadowTable[ locatorName ]
	return light, castShadow

end




this.IsAllowedSuppressor = function( locatorName )

	Fox.Log( "s10010_enemy.IsAllowedSuppressor(): locatorName:" .. tostring( locatorName ) )

	local suppressor = not not this.soldierAllowedSuppressorTable[ locatorName ]	
	return suppressor

end




return this
