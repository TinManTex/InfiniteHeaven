local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}
this.USE_COMMON_REINFORCE_PLAN = true	


local HELI_ROUTE = "rts_s10040_heli_0000"
local HELI_ROUTE_PATROL = "rts_s10040_heli_0002"
local HELI_ROUTE_HIDE  = "rts_s10040_heli_0003"
local HELI_ARRIVAL_NODE = 10	
local IDEN_ENE_POS = "s10040_Identifier"
local IDEN_KEY_ENE_POS = "enemy_checkPosition"
local CHECK_DIST = 30*30 
local HONEY_BEE_ID = TppEquip.EQP_WP_HoneyBee
local CHECK_RANGE_P2H = 30

local HOSTAGE_NAME = "hos_s10040_0000"
local VEHICLE_NAME	=	"vhc_s10040_0000"
local IDEN_KEY_HOS_POS = "hos_checkPosition"
local IDEN_KEY_HOS_POS1 = "hos_checkPosition1"	
local IDEN_KEY_HOS_POS2 = "hos_checkPosition2"	
local IDEN_KEY_HOS_POS3 = "hos_checkPosition3"	

local TRAVEL_ROUTE = "rts_bridgeRide_0000"
local TRAVEL_ROUTE_WALK = "rts_bridgeWalk_0001"
local PUT_ROUTE		= "rts_bridge_put_hostage"
local PUT_ROUTE2	= "rts_bridge_ride"






this.soldierRouteGroupList = {
	"groupA",
	"groupB",
	"groupC",
}


this.ImportantNPCList = {
	"sol_s10040_0000",
	"sol_s10040_0001",
	"sol_s10040_0002",
}


this.TalkLabelList = {
	HoneyBee	= "CT10040_25_000",
	Where	= "CT10040_25_001_where",
	There	= "CT10040_25_001__There"
}



this.TakeRoute = {
	Wait1 = {
		"rts_takeF2H_wait_0000",	
		"rts_takeF2H_wait_0001",
		"rts_takeF2H_wait_0002",
	},
	Walk1 = {
		"rts_takeF2H_0001",
		"rts_takeF2H_0001",
		"rts_takeF2H_0001",
	},
	Room1 = {
		"rts_serch_room1_0000",
		"rts_serch_room1_0001",
		"rts_serch_room1_0002",
	},
	Attack1 = {
		"rts_attack_room1_0000",
		"rts_attack_room1_0001",
		"rts_attack_room1_0002",
	},
	Walk2 = {
		"rts_takeF2H_0002",
		"rts_takeF2H_0002",
		"rts_takeF2H_0002",
	},
	Room2 = {
		"rts_serch_room2_0000",
		"rts_serch_room2_0001",
		"rts_serch_room2_0002",
	},
	Attack2 = {
		"rts_attack_room2_0000",
		"rts_attack_room2_0001",
		"rts_attack_room2_0002",
	},
	Walk3 = {
		"rts_takeF2H_0003",
		"rts_takeF2H_0003",
		"rts_takeF2H_0003",
	},
	Room3Wait = {
		"rts_GetHoneyBee_0000",
		"rts_GetHoneyBee_0001",
		"rts_GetHoneyBee_0002",
	},
	Room3PreGet = {
		"rts_GetHoneyBee_1000",
		"rts_GetHoneyBee_1001",
		"rts_GetHoneyBee_0002",
	},
	Room3Get = {
		"rts_GetHoneyBee_1000",
		"rts_GetHoneyBee_1001",
		"rts_GetHoneyBee_1002",
	},
	NoHoneyBee = {
		"rts_serch_hoken_0000",
		"rts_serch_hoken_0001",
		"rts_serch_hoken_0002",
	},
	BackToHeliWait = {
		"rts_GetHoneyBee_2000",
		"rts_GetHoneyBee_2001",
		"rts_GetHoneyBee_2002",
	},
	Hoken = {
		"rts_serch_hoken_0000",
		"rts_serch_hoken_0001",
		"rts_serch_hoken_0002",
	},
}



this.soldierDefine = {
	afgh_bridge_cp = {	
		"sol_bridge_0000",
		"sol_bridge_0001",
		"sol_bridge_0002",
		"sol_bridge_0003",
		"sol_bridge_0004",
		"sol_bridge_0005",
		"sol_bridge_0006",
		"sol_bridge_0007",
		"sol_bridge_0008",
		"sol_bridge_0009",		
		"sol_s10040_0000",	
		"sol_s10040_0001",	
		"sol_s10040_0002",	
	},
	afgh_fort_cp = {	
		"sol_fort_0000",
		"sol_fort_0001",
		"sol_fort_0002",
		"sol_fort_0003",
		"sol_fort_0004",
		"sol_fort_0005",
		"sol_fort_0006",
		"sol_fort_0007",
		"sol_fort_0008",
		"sol_fort_0009",
		"sol_fort_0010",
		"sol_fort_0011",
		"sol_fort_0012",
		"sol_fort_0013", 
		"sol_fort_0014", 
		"sol_fort_0015",
		"sol_fort_0016",
		"sol_fort_0017",
		nil
	},
	
	afgh_slopedEast_ob = {
		"sol_slopedEast_0000",
		"sol_slopedEast_0001",
		"sol_slopedEast_0002",
		"sol_slopedEast_0003",	
		nil
	},
	afgh_bridgeWest_ob = {
		"sol_bridgeWest_0000",
		"sol_bridgeWest_0001",
		"sol_bridgeWest_0002",
		
		nil
	},
	afgh_bridgeNorth_ob = {
		"sol_bridgeNorth_0000",
		"sol_bridgeNorth_0001",
		"sol_bridgeNorth_0002",
		nil
	},
	afgh_fortSouth_ob = {
		"sol_fortSouth_0000",
		"sol_fortSouth_0001",
		"sol_fortSouth_0002",
		nil
	},
	afgh_fortWest_ob = {
		"sol_fortWest_0000",
		"sol_fortWest_0001",
		"sol_fortWest_0002",
		"sol_fortWest_0003",
		nil
	},
	afgh_cliffSouth_ob = {
		"sol_cliffSouth_0000",
		"sol_cliffSouth_0001",
		"sol_cliffSouth_0002",
		"sol_cliffSouth_0003",
		nil
	},
	afgh_03_08_lrrp = { nil },
	afgh_03_11_lrrp = { nil },
	afgh_05_11_lrrp = { 
		"sol_05_11_0000",
		"sol_05_11_0001",
		lrrpTravelPlan = "travel_cliff", 
	 },
	afgh_05_33_lrrp = { nil },
	afgh_08_23_lrrp = { nil },
	afgh_09_10_lrrp = { nil },
	afgh_09_23_lrrp = { nil },
	afgh_10_31_lrrp = { nil },
	afgh_12_31_lrrp = { nil },
	afgh_12_37_lrrp = {
 		"sol_12_37_0000",
		"sol_12_37_0001",
		lrrpTravelPlan = "travel_mount",
	},
	afgh_33_37_lrrp = { nil },
	nil
}


this.disablePowerSettings = {
	"SHIELD",
}


this.soldierPowerSettings = {
		sol_bridge_0001 = { "SNIPER", },
		sol_bridge_0009 = { "SNIPER", },
		[ this.ImportantNPCList[1] ] = { },
		[ this.ImportantNPCList[2] ] = { },
		[ this.ImportantNPCList[3] ] = { },
}


this.parasiteSquadList = {
	"wmu_s10040_0000",
	"wmu_s10040_0001",
	"wmu_s10040_0002",
	"wmu_s10040_0003",
}





this.routeSets = {
	afgh_bridge_cp = {
		USE_COMMON_ROUTE_SETS = true,
		caution = {
			groupA = {
				"rt_bridge_c_0005",
				"rt_bridge_c_0006",
				"rt_bridge_c_0004",
				"rt_bridge_c_0004",
				"rt_bridge_c_0002",
				"rt_bridge_c_0003",
				"rt_bridge_c_0007",
				"rt_bridge_c_0000",
				"rt_bridge_c_0001",
				"rt_bridge_c_0008",
				"rt_bridge_c_0005",
				"rt_bridge_c_0006",
				"rt_bridge_c_0002",
			},
			groupB = {
			},
			groupC = {
			},
		},
	},
	afgh_bridgeWest_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	afgh_bridgeNorth_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	afgh_slopedEast_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	afgh_fort_cp = {
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupSerchA",
			"groupSerchB",
		},
		sneak_day = {
			groupA = {
				"rt_fort_d_0001",
				"rt_fort_d_0002",
				"rt_fort_d_0004_sub",
				"rt_fort_d_0005",
				"rts_fort_sbu_0002",
			},
			groupB = {
				"rt_fort_d_0000",
				"rt_fort_d_0007",
				"rt_fort_d_0010",
				"rt_fort_d_0011",
			},
			groupC = {
				"rt_fort_d_0003_sub",
				"rt_fort_d_0008",
				"rts_serch_0000",
				"rts_serch_0001",
			},
			groupSerchA = {
				"rts_serch_0002",
				"rts_serch_0003",
				"rts_serch_0004",
				"rts_fort_sbu_0000",
			},
			groupSerchB = {
				"rts_serch_0005",
				"rts_serch_0006",
				"rts_serch_0007",
				"rts_fort_sbu_0001",
			},

		},
		sneak_night = {
			groupA = {
				"rt_fort_n_0000",
				"rt_fort_n_0001",
				"rt_fort_n_0002",
				"rt_fort_n_0005",
				"rts_fort_sbu_0002",
			},
			groupB = {
				"rt_fort_n_0003_sub",
				"rt_fort_n_0004",
				"rt_fort_n_0010",
				"rt_fort_n_0009",
			},
			groupC = {
				"rt_fort_n_0008_sub",
				"rt_fort_n_0011",
				"rts_serch_0000",
				"rts_serch_0001",
			},
			groupSerchA = {
				"rts_serch_0002",
				"rts_serch_0003",
				"rts_serch_0004",
				"rts_fort_sbu_0000"
			},
			groupSerchB = {
				"rts_serch_0005",
				"rts_serch_0006",
				"rts_serch_0007",
				"rts_fort_sbu_0001",
			},
		},
		caution = {
			groupA = {
				"rt_fort_c_0001",
				"rt_fort_c_0008",
				"rt_fort_c_0002",
				"rt_fort_c_0002",
				"rts_serch_0002",
				"rt_fort_c_0004",
				"rt_fort_c_0005",
				"rt_fort_c_0000",
				"rt_fort_c_0007",
				"rt_fort_c_0010",
				"rt_fort_c_0010",
				"rts_serch_0000",
				"rts_serch_0001",
				"rts_serch_0002",
				"rts_serch_0003",
				"rts_serch_0004",
				"rts_serch_0004",
				"rts_serch_0005",
				"rts_serch_0006",
				"rts_serch_0007",
				"rts_serch_0007",
			},
			groupB = {
			},
			groupC = {
			},
			groupSerchA = {
			},
			groupSerchB = {
			},
		},
		travel = {
			takeHold = {
				"rts_takeF2H_wait_0000",
				"rts_takeF2H_wait_0001",
				"rts_takeF2H_wait_0002",
			},
		},
	},
	afgh_fortWest_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	afgh_fortSouth_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	afgh_cliffSouth_ob = {
		USE_COMMON_ROUTE_SETS = true
	},
	
	afgh_03_08_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_03_11_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_05_11_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_05_33_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_08_23_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_09_10_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_09_23_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_10_31_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_12_31_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_12_37_lrrp = { USE_COMMON_ROUTE_SETS = true,},
	afgh_33_37_lrrp = { USE_COMMON_ROUTE_SETS = true,},

}





this.combatSetting = {
	afgh_bridge_cp = {
		"gt_bridge_0000",
		"cs_bridge_0000",
	},
	afgh_fort_cp = {
		"gt_fort_0000",
		"cs_fort_0000",
	},
	nil
}





this.travelPlans = {
	travel_mount = {
		{ base="afgh_fortSouth_ob", },
		{ base="afgh_bridgeNorth_ob", },
	},
	travel_cliff = {
		{ base = "afgh_bridgeWest_ob"},
		{ base = "afgh_slopedEast_ob"},
	},
	nil
}






this.useGeneInter = {
	
	
	nil
}








this.DebugWarpHostage = function( pos )
	Fox.Log("warp hostage : temp")
	
	local gameObjectId={type="TppHostageUnique", index=0 }
	GameObject.SendCommand(gameObjectId,{
	    id="Warp",
	    degRotationY = 0,
	    position = pos,
	})
end

this.ChangeRouteHostage = function(routeName)
	if routeName == nil then
		routeName = ""
	end

	local gameObjectType = "TppHostageUnique"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, HOSTAGE_NAME)
	local command = {
	        id = "SetSneakRoute",
	        route = routeName,
	}
	GameObject.SendCommand( gameObjectId, command )
end

this.RouteHostageToFort = function()
	Fox.Log("change route")
	local pos = Vector3(2090.657, 463.229, -1796.693)
	this.DebugWarpHostage(pos)
end


this.RouteSetForSerch = function(routeGroup)
	Fox.Log("Set route for Serch route.")
	for i, name in pairs(this.ImportantNPCList)do
		if name == nil then
			Fox.Log("name is nil. mybe enemy is gone")
		else
			Fox.Log("soldir = "..name..". route = "..routeGroup[i] )
			TppEnemy.SetSneakRoute( name, routeGroup[i] )
			TppEnemy.SetCautionRoute(name,routeGroup[i] )
			GameObject.SendCommand( GameObject.GetGameObjectId( name ),	{ id = "SetForceFormationLine", enable = true }  ) 
		end
	end

end


this.RouteHostageToSerch2 = function() 
	Fox.Log("change route")
	local routeName = "rts_takeF2H_0002"
	this.ChangeRouteHostage(routeName)

end

this.RouteHostageToSerch3 = function() 
	Fox.Log("change route")
	local routeName = "rts_takeF2H_0003"
	this.ChangeRouteHostage(routeName)

end


this.ExecuteHostage = function() 
	local soldierId = {
		"sol_s10040_0000",
		"sol_s10040_0001",
		"sol_s10040_0002",
	}
	
	for i, name in pairs(soldierId ) do
		local gameObjectId = GameObject.GetGameObjectId( name )
		local lifeState = GameObject.SendCommand( gameObjectId, { id = "GetLifeStatus" } )
		if lifeState == TppGameObject.NPC_LIFE_STATE_NORMAL then
			local hostageId = GameObject.GetGameObjectId("TppHostageUnique", HOSTAGE_NAME )
			local command = { id="SetExecuteHostage", targetId=hostageId }
			GameObject.SendCommand( gameObjectId, command )
			return
		end
	end

end



this.CheckEnemyHeliPoint = function(objectId)
	local equipId = this.CheckEnemyEquip(objectId)
	if equipId ~= HONEY_BEE_ID then
		Fox.Log("not have honey bee")
		return false
	else
		Fox.Log("honey bee is ok")
	end
	
	Fox.Log("check enemy heli route")
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	local route = GameObject.SendCommand(gameObjectId, { id="GetUsingRoute" })
	local node = GameObject.SendCommand(gameObjectId, { id="GetDoingRouteEventIndex" })

	Fox.Log("route : "..route..". node : "..node )
	if route == StrCode32(HELI_ROUTE) and node == HELI_ARRIVAL_NODE then
		Fox.Log("Heli arrival")
		return true
	else
		Fox.Log("Heli not arrival")
		return false
	end

end



this.CheckEnemyPoint = function()
	Fox.Log("check enemy position. from enemy heli")

	local dist

	for i, soldiersName in pairs(this.ImportantNPCList)do
		local soldierID = GameObject.GetGameObjectId("TppSoldier2",soldiersName)

		if soldierID == nil then
			Fox.Error("soldierID is nil")
		else
			dist = this.CheckDistNPCtoLocator(soldierID,IDEN_ENE_POS, IDEN_KEY_ENE_POS)

			if this.CheckEnemyPosAndEquip(dist,soldierID)  then
				return true
			end
		end
	end
	
	Fox.Log("no weapon or no enemy")
	return false
end


this.CheckEnemyEquip = function(objectId)
	Fox.Log("check enemy have a honey bee")
	local command = { id = "GetCurrentEquipId" } 
	local equipId = GameObject.SendCommand( objectId, command ) 

	return equipId
end


this.CheckEnemyPosAndEquip = function(dist,soldierID)
	local equipId = this.CheckEnemyEquip(soldierID)
	Fox.Log("equipId : "..equipId )

	if dist < CHECK_DIST then
		Fox.Log("CheckEnemyPosAndEquip : dist is ok")
		if equipId == HONEY_BEE_ID then
			Fox.Log("CheckEnemyPosAndEquip : wepon and dist is ok")
			return true
		else
			Fox.Log("CheckEnemyPosAndEquip : wepon and dist is NG")			
			return false
		end
	else
		Fox.Log("CheckEnemyPosAndEquip : dist is NG")
		return false
	end
end


this.CheckEnemyAllDead = function()
	local lifeState
	local count = 0
	for i, soldiersName in pairs(this.ImportantNPCList)do
		lifeState = GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", soldiersName ), { id = "GetLifeStatus" } )
		if not(lifeState == TppGameObject.NPC_LIFE_STATE_NORMAL) then
			count = count + 1
		end
	end

	if count >= #this.ImportantNPCList then
		return true, count
	else
		return false, count
	end
end

this.CheckHostagePosition = function(iden,key)
	Fox.Log("Get Hostage Pos")
	
	if key == IDEN_KEY_HOS_POS then	
		local gameObjectId = GameObject.GetGameObjectId( HOSTAGE_NAME )
		local dist = this.CheckDistNPCtoLocator(gameObjectId, iden, key )

		if dist < CHECK_DIST then
			return true
		else
			return false
		end

	else
		
		return true
	end
end

this.CheckHostageInRoom1 = function()
	Fox.Log("check hostage to player range")
	local gameObjectType = "TppHostageUnique"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, HOSTAGE_NAME)
	local isInRange = GameObject.SendCommand( gameObjectId, {
	        id="IsInRange",
	        range = CHECK_RANGE_P2H,
	        target = { vars.playerPosX, vars.playerPosY, vars.playerPosZ },
	} )

	return isInRange
end


this.CheckDistNPCtoLocator = function(gameObjectId,identifer,ideKey)
	Fox.Log("::Get GameObject Pos")
	
	local command = { id = "GetPosition" }
	local position = GameObject.SendCommand( gameObjectId, command )

	if position == nil then
		Fox.Error("can not get position")
		return false
	end

	Fox.Log("::Get Locator Pos")
	local position2, rotQuat = Tpp.GetLocatorByTransform( identifer,ideKey )

	local point1 = TppMath.Vector3toTable( position )
	local point2 = TppMath.Vector3toTable( position2 )

	Fox.Log("position1 = "..point1[1]..","..point1[2]..","..point1[3])
	Fox.Log("position2 = "..point2[1]..","..point2[2]..","..point2[3])

	local dist = TppMath.FindDistance( point1, point2 )
	Fox.Log("dist : "..dist )

	if dist == false or nil then
		return false
	else
		return dist
	end
end




this.SetupHostage = function()

	
	local gameObjectId = GameObject.GetGameObjectId( HOSTAGE_NAME )
	GameObject.SendCommand( gameObjectId, { id = "SetLangType", langType="pashto" } )
	GameObject.SendCommand( gameObjectId, { id = "SetFollowed", enable = true } )
	GameObject.SendCommand( gameObjectId,  { id = "SetVoiceType", voiceType = "hostage_b" } )	
	GameObject.SendCommand( gameObjectId,  { id = "SetMovingNoticeTrap", enable = true } )
end


this.DisableHostageAndEnemy = function()
	for i, name in pairs(this.ImportantNPCList)do
		TppEnemy.SetDisable( name )
	end

	local gameObjectId = GameObject.GetGameObjectId( HOSTAGE_NAME )
	local command = { id="SetEnabled", enabled=false }
	GameObject.SendCommand( gameObjectId, command )
end



this.CheckCpFromEnemy = function(gameObjectId)
	
	local objectId
	for i, name in pairs(this.soldierDefine.afgh_bridge_cp)do
		objectId = GameObject.GetGameObjectId( "TppSoldier2", name )
		if gameObjectId == objectId then
			return true
		end
	end

	return false
end





this.PutHostageOnVehicle = function()
	
	Fox.Log("put hostage start")
	local nextRoute = PUT_ROUTE
	
	
	local status = GameObject.SendCommand( GameObject.GetGameObjectId( HOSTAGE_NAME), { id = "GetLifeStatus" } )
	if not (status == TppGameObject.NPC_LIFE_STATE_NORMAL) then
		nextRoute = TRAVEL_ROUTE
	end
	
	local lifeState
	local count = 0
	for i, name in pairs(this.ImportantNPCList)do
		lifeState = GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", name ), { id = "GetLifeStatus" } )
		if lifeState == TppGameObject.NPC_LIFE_STATE_NORMAL then
			count = count + 1
		end
	end
	
	
	if count == 0 then
		return false
	end

	this.ChangeRouteHostage( nextRoute )
	for i, name in pairs(this.ImportantNPCList ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			this.ForceRouteNotAlert( name, nextRoute )
			
		end
	end

end

this.SetUpVehicle = function()
	Fox.Log("set enemy to vehicle")
	
	local vehicleId = GameObject.GetGameObjectId( VEHICLE_NAME )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", "sol_s10040_0000" ), command )
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", "sol_s10040_0002" ), command )
	GameObject.SendCommand( GameObject.GetGameObjectId( HOSTAGE_NAME ), command )
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", "sol_s10040_0001" ), command )

end

this.StartTravelDrive = function()
	Fox.Log("StartTravelDrive")
	this.EnemyRideOnVehicle()
	
end


this.StartTravelWalk = function()
	Fox.Log("StartTravelWalk")
	this.EnemyRideOnVehicle("walk")
	this.ChangeRouteHostage( TRAVEL_ROUTE_WALK )
end


this.EnemyRideOnVehicle = function(flag)
	local gameObjectId

	
	local route = TRAVEL_ROUTE
	if flag == "walk" then
		route = TRAVEL_ROUTE_WALK
	end

	Fox.Log("#### StartTravel take to fort width ROA hostage ####")
	for i, name in pairs(this.ImportantNPCList ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			this.ForceRoute( name, route )
		end
	end
end

this.HostageRideOnVehicle = function()
	Fox.Log("hostage ride on vehicle")

	
	local gameObjectId={type="TppHostageUnique", index=0 }
	local vehicleId = 
	GameObject.SendCommand( gameObjectId, {
	        id = "RideVehicle",
	        vehicleId = GameObject.GetGameObjectIdByIndex("TppVehicle2", 1),
	        off = false,
			seatIndex=3,
	} )
end


this.WaitFort = function()
	Fox.Log("change route for wait fort")
	this.UnSetForceRoute()
	
	if svars.isDeadHostage == true 
	or svars.isGetInfoHoneyBee == true 
	or this.CheckHostagePosition(IDEN_ENE_POS, IDEN_KEY_HOS_POS) == false
	then 
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)
	else
		this.RouteSetForSerch(this.TakeRoute.Wait1)
		this.ChangeRouteHostage( this.TakeRoute.Wait1[1]  )
		
	end
end

this.ChangeRouteSetsTake = function()
	
	Fox.Log("check enemy and hostage")
	if this.CheckHostagePosition(IDEN_ENE_POS, IDEN_KEY_HOS_POS) and this.CheckEnemyOnRoute(this.TakeRoute.Wait1) > 0 then
		Fox.Log("change route.Start take")
		this.RouteSetForSerch(this.TakeRoute.Walk1)
		this.ChangeRouteHostage(this.TakeRoute.Walk1[1])

		return true
	else
		Fox.Log("check is NG")
		return false
	end
end




this.CheckConditionRoomDemo = function()
	local count = this.CheckEnemyOnRoute(this.TakeRoute.Room3Wait)
	if count == 3 then
		return true
	else
		return false
	end
end





this.CheckEnemyOnRoute = function(routeTable)
	Fox.Log("Check count of enemy for take route")
	local soldiers
	local count = 0
	for i, route in ipairs(routeTable) do
			soldiers = GameObject.SendCommand( { type="TppSoldier2" }, { id="GetGameObjectIdUsingRoute", route=route } )
			Fox.Log("route = "..route..", soldier num = "..#soldiers)

			for i, soldierName in ipairs(soldiers)do
				if TppEnemy.GetLifeStatus(soldierName) < TppEnemy.LIFE_STATUS.DEAD then
					count = count + 1
				end
			end
	end

	Fox.Log("count = "..count )
	return count
end




this.StartSerch1 = function()
	Fox.Log("change route for serch1")
	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS1) then
		this.RouteSetForSerch(this.TakeRoute.Room1)
		this.ChangeRouteHostage()
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)

	end
end
this.SerchAttack1 = function()
	Fox.Log("serch1 is end. start attack1.")

	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS1) then
		this.RouteSetForSerch(this.TakeRoute.Attack1)
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)
	end
end
this.SerchAttack2 = function()
	Fox.Log("serch2 is end. start attack2.")

	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS2) then
		this.RouteSetForSerch(this.TakeRoute.Attack2)
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)
	end
end

this.EndFind1 = function()
	Fox.Log("serch1 is end. change to next route.")

	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS1) then
		this.RouteSetForSerch(this.TakeRoute.Walk2)
		this.RouteHostageToSerch2()
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)

	end
end


this.StartSerch2 = function()
	Fox.Log("change route for serch2")
	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS2) then
		this.RouteSetForSerch(this.TakeRoute.Room2)
		this.ChangeRouteHostage()
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)
	end

end


this.EndFind2 = function()
	Fox.Log("serch2 is end. chane to next route.")

	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS2) then
		this.RouteSetForSerch(this.TakeRoute.Walk3)
		this.RouteHostageToSerch3()
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)
	end
end



this.WaitRoom = function()
	Fox.Log("change route for wait fort")

	if this.CheckHostagePosition(IDEN_ENE_POS,IDEN_KEY_HOS_POS3) then
		this.RouteSetForSerch(this.TakeRoute.Room3Wait)
		this.ChangeRouteHostage()
	else
		Fox.Log("hostage is gone")
		this.RouteSetForSerch(this.TakeRoute.Hoken)

	end
end


this.SerchRoomWait = function()
	
	Fox.Log("change route for wait fort")
	this.RouteSetForSerch(this.TakeRoute.Room3PreGet)
end

this.SerchRoom = function()
	
	Fox.Log("change route for wait fort")
	this.RouteSetForSerch(this.TakeRoute.Room3Get)
end


this.SerchRoomNoDemo = function()
	
	local routeName = "rts_GetHoneyBee_1002"

	local enemyNameTable = {
		"sol_s10040_0002",
		"sol_s10040_0001",
		"sol_s10040_0000",
	}

	for i, name in ipairs(enemyNameTable)do
		local gameObjectId = GameObject.GetGameObjectId( name )
		local lifeState = GameObject.SendCommand( gameObjectId, { id = "GetLifeStatus" } )
		if lifeState == TppGameObject.NPC_LIFE_STATE_NORMAL then
				TppEnemy.SetSneakRoute( name, routeName )
				TppEnemy.SetCautionRoute(name,routeName )
			return
		end
	end
end

this.ChangeRouteNotHoneyBee = function()
	
	Fox.Log("change route. not honey bee route")
	this.ExecuteHostage()
	this.RouteSetForSerch(this.TakeRoute.NoHoneyBee)
end

this.BackToHeliWait = function()
	
	Fox.Log("change route. wait end of demo2")
	this.RouteSetForSerch(this.TakeRoute.BackToHeliWait)

end


this.DieHostage = function()
	local gameObjectId = GameObject.GetGameObjectId( HOSTAGE_NAME )
	GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "unlocked", on = true, updateModel = true } )
	GameObject.SendCommand( gameObjectId, { id = "ChangeLifeState", state = TppGameObject.NPC_LIFE_STATE_DEAD } )
	GameObject.SendCommand( gameObjectId, { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_EXECUTED } )
end



this.EnemyHeliSetRoute = function(routeId)
	Fox.Log("change route Enemy Heli "..routeId )
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetCommandPost",	cp="afgh_fortSouth_ob" })

end


this.EnemyHeliRecoverAndEyeOff = function()
	Fox.Log("recover Enemy Heli" )
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="Recover"})
	GameObject.SendCommand(gameObjectId, { id="SetEyeMode", 	mode="Close" })
end


this.EnemyHeliAround = function()
	this.EnemyHeliSetRoute(HELI_ROUTE_PATROL)
end


this.EnemyHeliHideRoute = function()
	Fox.Log("change force route Enemy Heli. for Hide" )
	local routeId = HELI_ROUTE_HIDE
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="SetAlertRoute", 		route=routeId,	point=0 })
	GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", 		route=routeId,	point=0 })
	GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", 	route=routeId,	point=0 })
end


this.BackToHeli = function()
	this.RouteSetForSerch(this.TakeRoute.Room3Wait)
	this.ExecuteHostage()

end




this.ForceRoute = function(enemyId,route)
	Fox.Log("Set Force Route "..enemyId..":"..route )
	local gameObjectId = GameObject.GetGameObjectId( enemyId )
	GameObject.SendCommand( gameObjectId,	{ id = "SetSneakRoute", 	route = route, point = 0 } )
	GameObject.SendCommand( gameObjectId,	{ id = "SetCautionRoute", 	route = route, point = 0 } )
	GameObject.SendCommand( gameObjectId, 	{ id = "SetAlertRoute", 	enabled = true, route=route, point=0 }  ) 
	GameObject.SendCommand( gameObjectId,	{ id = "SetRestrictNotice", enabled = true }  ) 
	GameObject.SendCommand( gameObjectId,	{ id = "SetForceFormationLine", enable = true }  ) 
end


this.ForceRouteNotAlert = function(enemyId,route)
	Fox.Log("Set Force Route "..enemyId..":"..route )
	local gameObjectId = GameObject.GetGameObjectId( enemyId )
	GameObject.SendCommand( gameObjectId,	{ id = "SetSneakRoute", 	route = route, point = 0 } )
	GameObject.SendCommand( gameObjectId,	{ id = "SetCautionRoute", 	route = route, point = 0 } )
end



this.UnSetForceRoute = function()
	local gameObjectId

	for i, name in pairs(this.ImportantNPCList ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			Fox.Log("UnSet Force Route "..name )
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId,	{ id = "SetSneakRoute", 	route = "", point = 0 } )
			GameObject.SendCommand( gameObjectId,	{ id = "SetCautionRoute", 	route = "", point = 0 } )
			GameObject.SendCommand( gameObjectId, { id="SetAlertRoute", enabled = false , route = ""}  ) 
			GameObject.SendCommand( gameObjectId, { id="SetRestrictNotice", enabled = false }  ) 
		end
	end
end



this.SetCpTakeEnemy = function(setName)

	local cpName = "afgh_fort_cp"
	if Tpp.IsTypeString( setName ) then 
		cpName = setName
	end
	local gameObjectId
	local command = { id="SetCommandPost", 	cp=cpName }
	Fox.Log("take enemy set to fort cp :"..cpName)

	for i, name in pairs(this.ImportantNPCList ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId, command ) 
		end
	end
end



this.ChangeStateEnemyInFort = function(flag)
	local enable = true
	if flag == false then
		enable = false
	end
	Fox.Log("change zombie enemy in fort")

	local gameObjectId
	local command = { id = "SetZombie", enabled=enable,  isZombieSkin=enable }

	for i, name in pairs(this.soldierDefine.afgh_fort_cp) do
		Fox.Log("zombie : "..name )
		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)
		GameObject.SendCommand( gameObjectId, command )
	end
	for i, name in pairs(this.ImportantNPCList) do
		Fox.Log("zombie : "..name )
		gameObjectId = GameObject.GetGameObjectId("TppSoldier2",name)
		GameObject.SendCommand( gameObjectId, command )
	end
end




this.CheckParasiteMessage = function(gameObjectId)
	Fox.Log("check where form message.")
	for i,paraId in pairs(this.parasiteSquadList) do
		if gameObjectId == GameObject.GetGameObjectId("TppParasite2",paraId)then
			return true
		end
	end
	return false
end





this.TalkEvent = function(speker,friend,label)

	local status = TppEnemy.GetLifeStatus(speker)
	if not ( status == TppEnemy.LIFE_STATUS.SNEAK ) then
		Fox.Log("speaker is gone. change next route")
		s10040_sequence.ChangeRouteEndTalk()
		return false
	end

	local speakerGameObjectId = GameObject.GetGameObjectId( speker )
	local friendGameObjectId = GameObject.GetGameObjectId( friend )
	local talkLabel	= this.TalkLabelList.HoneyBee
	if label ~= nil then
		talkLabel = label
	end

	Fox.Log("Talk Event : "..speker.." to "..friend..". talk about "..label )
	local command = { id = "CallConversation", label = talkLabel, friend	= friendGameObjectId, }
	GameObject.SendCommand( speakerGameObjectId, command )
end

this.ChangeRouteAiAct = function(label)
	if label == StrCode32(this.TalkLabelList.HoneyBee)then
		Fox.Log("change route ai act : talk about where")
		this.TalkEvent(this.ImportantNPCList[2], HOSTAGE_NAME, this.TalkLabelList.Where)
	elseif label == StrCode32(this.TalkLabelList.Where)then
		Fox.Log("change route ai act : talk about there")
		this.TalkEvent(this.ImportantNPCList[1], HOSTAGE_NAME, this.TalkLabelList.There)
	elseif label == StrCode32(this.TalkLabelList.There)then
		Fox.Log("change route ai act : next route")
		s10040_sequence.ChangeRouteEndTalk()
	else
		
		Fox.Log("no label.")
		this.TalkEvent(this.ImportantNPCList[1], HOSTAGE_NAME, this.TalkLabelList.HoneyBee)
	end
end







this.SetForceRealize = function()
	Fox.Log("set force realize: for demo character")
	for i, soldiersName in pairs(this.ImportantNPCList)do
		local soldierID = GameObject.GetGameObjectId("TppSoldier2",soldiersName)

		if soldierID == nil then
			Fox.Error("soldierID is nil")
		else
			Fox.Log("set force realize : "..soldiersName )
			GameObject.SendCommand(soldierID, { id="SetVip" } )
			GameObject.SendCommand(soldierID, { id="SetForceRealize" } )
		end
	end
end



this.SetStartRoute = function()
		Fox.Log("change route.for start demo.check when enemy and hostage")
		
		if svars.isDebugCheck == 110 then
			Fox.Log("before game over")
			local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
			GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", 	route=HELI_ROUTE,node=4 })
			GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", 	route=HELI_ROUTE,node=4 })
			GameObject.SendCommand(gameObjectId, { id="SetCommandPost",	cp="afgh_fort_cp" })
			GameObject.SendCommand(gameObjectId, { id="SetEyeMode", 	mode="Close" })
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_takeH2H_0000",24 )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_takeH2H_0000",24 )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_takeH2H_0000",24 )

		elseif svars.isDebugCheck == 50 then
			Fox.Log("hostage in room")
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_GetHoneyBee_0000" )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_GetHoneyBee_0001" )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_GetHoneyBee_0002" )
			this.DebugWarpHostage( Vector3(2047.495, 457.152, -1920.150) )

		elseif svars.isDebugCheck == 20 then
			Fox.Log("hostage in serch room2")
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_serch_room2_0000" )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_serch_room2_0001" )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_serch_room2_0002" )
			this.DebugWarpHostage( Vector3(2119.802, 473.498, -1856.097) )
			GkEventTimerManager.Start("Timer_Serch2", 30)

		elseif svars.isDebugCheck == 15 then
			Fox.Log("hostage in serch room1")
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_serch_room1_0000" )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_serch_room1_0001" )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_serch_room1_0002" )
			this.DebugWarpHostage( Vector3(2102.306, 473.326, -1820.150) )
			GkEventTimerManager.Start("Timer_Serch1", 30)
		elseif svars.isDebugCheck == 10 then
			Fox.Log("hostage in fort")
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_takeF2H_wait_0000" )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_takeF2H_wait_0001" )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_takeF2H_wait_0002" )

			this.RouteHostageToFort()
		elseif( svars.eventSequenceNum == 0 )then	
			Fox.Log("hostage in bridge")
			TppEnemy.SetSneakRoute( "sol_s10040_0000", 	"rts_bridgeWait_0000" )	
			TppEnemy.SetSneakRoute( "sol_s10040_0001", 	"rts_bridgeWait_0001" )
			TppEnemy.SetSneakRoute( "sol_s10040_0002", 	"rts_bridgeWait_0002" )
		end
end

this.SetNotShiftEnemy = function()
	
end

this.SetVoiceType = function()
	Fox.Log("Set Voice Type for demo enemy")
	local gameObjectId
	gameObjectId = GameObject.GetGameObjectId("TppSoldier2", this.ImportantNPCList[1] )
	GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", voiceType="ene_a" } )
	gameObjectId = GameObject.GetGameObjectId("TppSoldier2", this.ImportantNPCList[2] )
	GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", voiceType="ene_b" } )
	gameObjectId = GameObject.GetGameObjectId("TppSoldier2", this.ImportantNPCList[3] )
	GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", voiceType="ene_c" } )
end



this.InitEnemy = function ()
	this.SetNotShiftEnemy()

end



this.SetUpEnemy = function ()
	
	GameObject.SendCommand( { type="TppVehicle2", }, { id="Spawn", locator=VEHICLE_NAME, type=Vehicle.type.EASTERN_LIGHT_VEHICLE, } )

	TppEnemy.RegisterCombatSetting( this.combatSetting )
	this.SetForceRealize()
	
	if DEBUG then
		this.SetStartRoute()
	end
	this.SetVoiceType()

	
	TppEnemy.AssignUniqueStaffType{
	        locaterName = HOSTAGE_NAME,
	        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10040_DEAF_HOSTAGE,
	        
	}

	TppEnemy.AssignUniqueStaffType{
	        locaterName = this.ImportantNPCList[1],
	        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10040_ENEMY_01,
	        alreadyExistParam = { staffTypeId =5, randomRangeId =6, skill =nil }

	}
	TppEnemy.AssignUniqueStaffType{
	        locaterName = this.ImportantNPCList[2],
	        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10040_ENEMY_02,
	        alreadyExistParam = { staffTypeId =2, randomRangeId =6, skill ="Study" }
	}
	TppEnemy.AssignUniqueStaffType{
	        locaterName = this.ImportantNPCList[3],
	        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10040_ENEMY_03,
	        alreadyExistParam = { staffTypeId =10, randomRangeId =6, skill ="QuickReload" }
	}

	this.SetupHostage()

	Fox.Log("SetRelativeVehicle")
	this.SetUpVehicle()
end


this.OnLoad = function ()
	Fox.Log("*** s10040 onload ***")
end





return this
