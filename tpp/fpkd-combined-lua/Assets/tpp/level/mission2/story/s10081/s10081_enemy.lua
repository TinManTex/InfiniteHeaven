local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}


this.routeChangeTableRoot = {}


this.USE_COMMON_REINFORCE_PLAN = true

local DESTROY_TIME =15





this.soldierDefine = {

	mafr_diamond_cp = {
		"sol_diamond_0000",
		"sol_diamond_0001",
		"sol_diamond_0002",
		"sol_diamond_0003",
		"sol_diamond_0004",
		"sol_diamond_0005",
		"sol_diamond_0006",
		"sol_diamond_0007",
		nil
	},

	mafr_banana_cp = {
		"sol_banana_0000",
		"sol_banana_0001",
		"sol_banana_0002",
		"sol_banana_0003",
		"sol_banana_0004",
		"sol_banana_0005",
		"sol_banana_0006",
		"sol_banana_0007",
		nil
	},


	mafr_diamondWest_ob = {
		"sol_diamondWest_0000",
		"sol_diamondWest_0001",
		"sol_diamondWest_0002",
		"sol_diamondWest_0003",
		"sol_diamondWest_0004",
		"sol_diamondWest_0005",
		"sol_diamondWest_0006",
		"sol_diamondWest_0007",
		"sol_diamondWest_0008",
		"sol_diamondWest_0009",
		"sol_diamondWest_0010",
		"sol_diamondWest_0011",
		nil
	},

	mafr_diamondSouth_ob = {
		"sol_diamondSouth_0000",
		"sol_diamondSouth_0001",
		"sol_diamondSouth_0002",
		"sol_diamondSouth_0003",
		nil
	},

	mafr_savannahNorth_ob = {
		"sol_savannahNorth_0000",
		"sol_savannahNorth_0001",
		"sol_savannahNorth_0002",
		"sol_savannahNorth_0003",
		"sol_savannahNorth_0004",
		"sol_savannahNorth_0005",
		nil
	},

	mafr_bananaEast_ob = {
		"sol_bananaEast_0000",
		"sol_bananaEast_0001",
		"sol_bananaEast_0002",
		"sol_bananaEast_0003",
		"sol_bananaEast_0004",
		"sol_bananaEast_0005",
		nil
	},

	mafr_diamondOp_cp = {
		"sol_diamondOp_0000",
		"sol_diamondOp_0001",
		nil
	},

	mafr_pursuit_lrrp = {
		nil
	},

	
	mafr_08_25_lrrp = {
		nil
	},
	mafr_09_25_lrrp = {
		"sol_09_25_0000",
		"sol_09_25_0001",
		lrrpTravelPlan = "travelBanana",
		nil
	},
	mafr_11_26_lrrp = {
		"sol_11_26_0000",
		"sol_11_26_0001",
		lrrpTravelPlan = "travelDiamond", 

		nil
	},
	

	mafr_10_11_lrrp= {
		nil
	},
	mafr_10_26_lrrp= {
		nil
	},
	mafr_08_10_lrrp	= {
		nil
	},

	nil
}

this.soldierSubTypes = {
		
		PF_C = {
			 this.soldierDefine.mafr_diamondOp_cp,
		},
}


this.soldierPowerSettings = {
	sol_diamondWest_0010 =	{"SOFT_ARMOR","HELMET"},
	sol_diamondWest_0011 =	{"SOFT_ARMOR","HELMET"},
}





local spawnList = {
	{ id="Spawn", locator="Vehs_lvDOp_0000",	type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },
	{ id="Spawn", locator="Vehs_lvDW_0000",		type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },	
	{ id="Spawn", locator="Vehs_lvDW_0001", 	type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },		
	{ id="Spawn", locator="Vehs_truck_0000", 	type=Vehicle.type.WESTERN_TRUCK, subType=Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX,  paintType=Vehicle.paintType.FOVA_0 },	
}

this.vehicleDefine = {
	instanceCount   = #spawnList + 1, 
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( spawnList )
end





this.routeSets = {

	

	mafr_banana_cp 			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_savannahNorth_ob 	= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_diamondSouth_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_bananaEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_diamond_cp			= { USE_COMMON_ROUTE_SETS = true,	},

	
	mafr_08_25_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_09_25_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_10_11_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_10_26_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_08_10_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	mafr_11_26_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_11to26 = {
				"rt_11to26_0000",
				"rt_11to26_0000",
			},
			lrrp_26to11 = {
				"rt_26to11_0000",
				"rt_26to11_0000",
			},
			rp_11to26 = {
				"rt_11to26_0000",
				"rt_11to26_0000",
				"rt_11to26_0000",
				"rt_11to26_0000",
			},
			rp_26to11 = {
				"rt_26to11_0000",
				"rt_26to11_0000",
				"rt_26to11_0000",
				"rt_26to11_0000",
			},
		},
		nil
	},

	
	mafr_diamondWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rts_diamondWest_d_0000",
				"rts_diamondWest_d_0001",
				"rts_diamondWest_d_0002",
				"rts_diamondWest_d_0003",
			},
			groupB = {
				"rt_diamondWest_d_0003",
				"rts_diamondWest_d_0004",
				"rt_diamondWest_d_0002",
				"rts_diamondWest_d_0009",	
			},
			groupC = {
				"rts_diamondWest_d_0005",
				"rts_diamondWest_d_0007",
				"rts_diamondWest_d_0008",
				"rts_diamondWest_d_0006",	
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rt_diamondWest_n_0000",
				"rt_diamondWest_n_0001",
				"rt_diamondWest_n_0004",
				"rts_diamondWest_n_0000",
			},
			groupB = {
				"rts_diamondWest_n_0001",
				"rts_diamondWest_n_0003",
				"rts_diamondWest_n_0004",
				"rts_diamondWest_n_0002",	
			},
			groupC = {
				"rt_diamondWest_n_0005",
				"rts_diamondWest_n_0005",
				"rts_diamondWest_n_0006",
				"rt_diamondWest_n_0006",	
			},
			nil
		},

		caution = {
			groupA = {
				"rts_diamondWest_c_0000",
				"rts_diamondWest_c_0001",
				"rt_diamondWest_c_0001",
				"rts_diamondWest_c_0003",
				"rt_diamondWest_c_0003",
				"rts_diamondWest_c_0003",
				"rt_diamondWest_c_0003",
				"rt_diamondWest_c_0005",
				"rt_diamondWest_c_0006",
				"rts_diamondWest_c_0002",
				"rt_diamondWest_c_0004",
				"rt_diamondWest_c_0002",
			},
			groupB = {},
			groupC = {},
			nil
		},
		hold = {
			default = {
			},
		},

		sleep = {
			default = {
				"rt_diamondWest_s_0000",
				"rt_diamondWest_s_0001",
				"rts_diamondWest_s_0000",
				"rts_diamondWest_s_0001",
			},
		},


		nil
	},

	

	mafr_diamondOp_cp = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"rts_dimondOp_d_0000",
				"rts_dimondOp_d_0001",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rts_dimondOp_d_0000",
				"rts_dimondOp_d_0001",
			},
			nil
		},
		caution = {
			groupA = {
				"rts_dimondOp_c_0000",
				"rts_dimondOp_c_0001",
			},
			nil
		},
		hold = {
			default = {
			},
		},
		nil
	},

	
	mafr_pursuit_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_DiamondOp = {
				"rts_dimondOp_drive",
				"rts_dimondOp_drive",
			},
			lrrp_DiamondWest00 = {
				"rts_diamondWest_drive_0000",
				"rts_diamondWest_drive_0000",
			},
			lrrp_DiamondWest01 = {
				"rts_diamondWest_drive_0001",
				"rts_diamondWest_drive_0001",
			},
		},
		nil
	},



	nil
}








this.lrrpHoldTime = 15

this.travelPlans = {
	

	travelDiamond = {
		{ base="mafr_diamondSouth_ob" },
		{ base="mafr_diamond_cp" },
	},

	travelBanana = {
		{ base="mafr_savannahNorth_ob" },
		{ base="mafr_banana_cp" },
	},


	
	lrrp_from_DiamondOp = {
		ONE_WAY = true,
		{ cp="mafr_pursuit_lrrp", 		routeGroup={ "travel", "lrrp_DiamondOp" } },
		{ cp="mafr_bananaEast_ob" },
	},

	lrrp_from_DiamondWest00 = {
		ONE_WAY = true,
		{ cp="mafr_pursuit_lrrp", 		routeGroup={ "travel", "lrrp_DiamondWest00" } },
		{ cp="mafr_bananaEast_ob" },
	},

	lrrp_from_DiamondWest01 = {
		ONE_WAY = true,
		{ cp="mafr_pursuit_lrrp", 		routeGroup={ "travel", "lrrp_DiamondWest01" } },
		{ cp="mafr_bananaEast_ob" },
	},

}








function this.Messages()
	return
	StrCode32Table {
		GameObject = {
			{	
				msg = "RoutePoint2",
				func = function (id,routeId,routeNode,sendM)
					this.OnRoutePoint(id,routeId,routeNode,sendM)
				end
			},

			{	
				msg = "RouteEventFaild",sender = "hos_spy",
				func = function (id,routeId,failType)
					if failType == TppGameObject.ROUTE_EVENT_FAILED_TYPE_VEHICLE_GET_IN then
						TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_toHaven")
					end
				end
			},

			{
				
				msg = "VehicleAction",sender = "hos_spy",
				func = function ( rideMemberId, vehicleId, actionType )
					
					if ( actionType == TppGameObject.VEHICLE_ACTION_TYPE_GOT_IN_VEHICLE) then
						svars.SpyVehicleId = vehicleId
					else

					end

				end
			},
			
			{
				
				msg = "ChangePhase",sender = "mafr_diamondWest_ob",
				func = function ( GameObjectId, phaseName )
					if phaseName >= TppGameObject.PHASE_CAUTION then
						this.SpyEscape()
					end
					
					if phaseName == TppGameObject.PHASE_EVASION then
						
					end
				end
			},
			
			












		},
		Timer = {
			{ msg = "Finish",sender = "DebugMUTEKITimer",
				func = function()
					
					TppEnemy.UnsetSneakRoute( "hos_spy")

					
					DEBUG.SetDebugMenuValue("Hostage2:Unique", "MUTEKI", "None")
					
					
					
				end
			},
			{ msg = "Finish",sender = "WarpTimer",
				func = function()
					this.WarpAccidentTruck()
				end
			},

			
			{ msg = "Finish",sender = "DestroyTimer",
				func = function()
					if not svars.isExplosionTruck then
						
						this.truckWarp()
						
						this.DestroySpyVehicle()
					end
				end
			},

			nil
		},
		Trap = {
			{ msg = "Enter", sender = "trap_nearDiamondWest_Target",func = this.SpyEscape },
			{ msg = "Enter", sender = "trap_corpseBloodStain",func = this.SetCorpseBlood },
			
			
























			
			
			nil
		},
		nil
	}
end






this.routeChangeTableRoot[ Fox.StrCode32( "spy_escape_end" ) ] = {

	{ 	func = function()
			TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_rideStay")
		end
	},
}

this.routeChangeTableRoot[ Fox.StrCode32( "rideStay" ) ] = {

	{ 	func = function()
			local diamondWestPhase = TppEnemy.GetPhase( "mafr_diamondWest_ob" )
			if diamondWestPhase ~= TppEnemy.PHASE.ALERT then
				if(svars.isPlayerTrukStartArea == true) or (svars.isKnowSpy == true) then
				
					
					s10081_sequence.OffCheckPointSave()
				
					svars.SpyStatus = s10081_sequence.SPY_STATUS.SPY_RIDETRUCK
					
					TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_ride")
				end
			end
		end
	},
}

this.routeChangeTableRoot[ Fox.StrCode32( "spyFaint" ) ] = {

	{ 	func = function()
			svars.SpyStatus = s10081_sequence.SPY_STATUS.SPY_INJURED

			
			local gameObjectId = GameObject.GetGameObjectId("hos_spy")
			local command = { id = "ChangeLifeState", state = TppGameObject.NPC_LIFE_STATE_FAINT }
			local actionState = GameObject.SendCommand( gameObjectId, command )

			
			command = { id="SetEverDown", enabled=true }
			GameObject.SendCommand( gameObjectId, command )
			
			this.OnSpyFlag(gameObjectId,"event")	

			this.WarpAccidentTruck()
		end
	},
}

this.routeChangeTableRoot[ Fox.StrCode32( "EndSpyHaven" ) ] = {

	{ 	func = function()
			svars.SpyStatus = s10081_sequence.SPY_STATUS.SPY_HAVEN

			
			TppEnemy.UnsetSneakRoute( "hos_spy")

			GkEventTimerManager.Start( "SpyHavenTimer", 5 )

		end
	},
}


this.routeChangeTableRoot[ Fox.StrCode32( "spyEscapeTruck" ) ] = {

	{ 	func = function()
			svars.isPreliminaryFlag02 = true
			s10081_sequence.UpdateObjectives("SpyEscapeTruck")
			
		end
	},
}













this.routeChangeTableRoot[ Fox.StrCode32( "lrrpEnd_DW00" ) ] = {
	{ beforeRouteName = "rts_diamondWest_drive_0000", afterRouteName = "rts_hunting_DW_0000_1",},
}
this.routeChangeTableRoot[ Fox.StrCode32( "lrrpEnd_DW01" ) ] = {
	{ beforeRouteName = "rts_diamondWest_drive_0001", afterRouteName = "rts_hunting_DW_0001_1",},
}
this.routeChangeTableRoot[ Fox.StrCode32( "lrrpEnd_DOp00" ) ] = {
	{ beforeRouteName = "rts_dimondOp_drive", afterRouteName = "rts_hunting_DOp_0000_1",},
}


this.routeChangeTableRoot[ Fox.StrCode32( "huntingShift" ) ] = {

	
	{ enemyName = "sol_bananaEast_0000", afterRouteName = "rts_hunting_BE_0000_1" },
	{ enemyName = "sol_bananaEast_0001", afterRouteName = "rts_hunting_BE_0000_1" },
	{ enemyName = "sol_bananaEast_0002", afterRouteName = "rts_hunting_BE_0001_1" },
	{ enemyName = "sol_bananaEast_0003", afterRouteName = "rts_hunting_BE_0001_1" },
	{ enemyName = "sol_bananaEast_0004", afterRouteName = "rts_hunting_BE_0002_1" },
	{ enemyName = "sol_bananaEast_0005", afterRouteName = "rts_hunting_BE_0002_1" },

	
	{ beforeRouteName = {"rt_banana_d_0002","rt_banana_n_0003","rt_banana_c_0000","rt_banana_h_0000","rt_banana_s_0000"}, 	afterRouteName = "rts_hunting_B_0000" },
	{ beforeRouteName = {"rt_banana_d_0003","rt_banana_n_0000","rt_banana_c_0001","rt_banana_h_0001","rt_banana_s_0001"}, 	afterRouteName = "rts_hunting_B_0000" },
	{ beforeRouteName = {"rt_banana_d_0000","rt_banana_n_0001","rt_banana_c_0002","rt_banana_h_0002","rt_banana_s_0002"}, 	afterRouteName = "rts_hunting_B_0001" },
	{ beforeRouteName = {"rt_banana_d_0006","rt_banana_n_0002","rt_banana_c_0005","rt_banana_h_0003","rt_banana_s_0003"}, 	afterRouteName = "rts_hunting_B_0001" },

	
	{ enemyName = "sol_savannahNorth_0002", afterRouteName = "rts_hunting_SN_0000" },
	{ enemyName = "sol_savannahNorth_0003", afterRouteName = "rts_hunting_SN_0001" },
}




this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_DW_0000_1" ) ] = {
	{ beforeRouteName = "rts_hunting_DW_0000_1", afterRouteName = {"rts_hunting_DW_0000_2A","rts_hunting_DW_0000_2B"},},
}
this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_DW_0001_1" ) ] = {
	{ beforeRouteName = "rts_hunting_DW_0001_1", afterRouteName = {"rts_hunting_DW_0001_2A","rts_hunting_DW_0001_2B"},},
}
this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_DOp_0000_1" ) ] = {
	{ beforeRouteName = "rts_hunting_DOp_0000_1", afterRouteName = {"rts_hunting_DOp_0000_2A","rts_hunting_DOp_0000_2B"},},
}


this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_BE_0000_1" ) ] = {
	{ beforeRouteName = "rts_hunting_BE_0000_1", afterRouteName = {"rts_hunting_BE_0000_2A","rts_hunting_BE_0000_2B"},},
}
this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_BE_0001_1" ) ] = {
	{ beforeRouteName = "rts_hunting_BE_0001_1", afterRouteName = {"rts_hunting_BE_0001_2A","rts_hunting_BE_0001_2B"},},
}
this.routeChangeTableRoot[ Fox.StrCode32( "End_hunting_BE_0002_1" ) ] = {
	{ beforeRouteName = "rts_hunting_BE_0002_1", afterRouteName = {"rts_hunting_BE_0002_2A","rts_hunting_BE_0002_2B"},},
}




















this.routeNameChangeOneSolName = function(routeName)

	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )

	if soldiers then
		return soldiers[1]
	else
		return nil
	end
end


this.routeNameChageSolNames = function(routeName)

	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )

	return soldiers
end





this.OnRoutePoint = function( gameObjectId, routeId, routeNodeIndex, messageId )

	Fox.Log( "s10081_sequence.OnRoutePoint( gameObjectId:" .. tostring(gameObjectId) .. ", routeId:" .. tostring(routeId) ..
			", routeNodeIndex:" .. tostring(routeNodeIndex) .. ", messageId:" .. tostring(messageId) ..  " )" )

	local routeChangeTables = this.routeChangeTableRoot[ messageId ]
	if routeChangeTables then
		for i, routeChangeTable in ipairs( routeChangeTables ) do
			local enemyNames = {} 

			if routeChangeTable.enemyName then
				enemyNames =  { routeChangeTable.enemyName }

			elseif routeChangeTable.beforeRouteName then
				local beforeRouteName = routeChangeTable.beforeRouteName

				if not Tpp.IsTypeTable( beforeRouteName ) then
					beforeRouteName = { beforeRouteName }
				end
				for i,routeName in ipairs(beforeRouteName) do
					enemyNames = this.routeNameChageSolNames(routeName)

					if enemyNames and next( enemyNames ) then
						break
					end
				end
			end


			local afterRouteName = routeChangeTable.afterRouteName
			if not Tpp.IsTypeTable( afterRouteName ) then
				afterRouteName = { afterRouteName }
			end

			if enemyNames and next( enemyNames ) and afterRouteName and next( afterRouteName ) then

				for i,enemyName in pairs(enemyNames) do

					Fox.Log(enemyName .. " / " .. afterRouteName[i % #afterRouteName +1])

					TppEnemy.SetSneakRoute( enemyName , afterRouteName[i % #afterRouteName +1 ])
					TppEnemy.SetCautionRoute( enemyName , afterRouteName[i % #afterRouteName +1 ])

				end

			else
				Fox.Log( "s10081_sequence.OnRoutePoint(): There is no enemyName or routeId!" )
			end
			if routeChangeTable.func then
				routeChangeTable.func()
			end
		end
	else
		Fox.Log( "s10081_sequence.OnRoutePoint(): There is no routeChangeTables!" )
	end

end




this.PursuitUnitTravelStart = function()

	
	local PURSUIT_GROUP_ROUTE = {
		lrrp_from_DiamondOp = {
			{"rts_dimondOp_d_0000",		"rts_dimondOp_c_0000"},
			{"rts_dimondOp_d_0001",		"rts_dimondOp_c_0001"},
		},
		lrrp_from_DiamondWest00 = {
			{"rts_diamondWest_d_0004",	"rt_diamondWest_n_0004",	"rt_diamondWest_c_0003" , "rts_diamondWest_h_0000", "rt_diamondWest_s_0000"},
			{"rt_diamondWest_d_0003",	"rt_diamondWest_n_0005",	"rt_diamondWest_c_0001" , "rts_diamondWest_h_0001", "rt_diamondWest_s_0000"},
		},
		lrrp_from_DiamondWest01 = {
			{"rt_diamondWest_d_0002",	"rt_diamondWest_n_0001",	"rt_diamondWest_c_0005" , "rts_diamondWest_h_0002", "rts_diamondWest_s_0000"},
			{"rts_diamondWest_d_0008",	"rts_diamondWest_n_0006",	"rt_diamondWest_c_0006" , "rts_diamondWest_h_0003", "rts_diamondWest_s_0000"},
		},
	}

	local cmdStartTravel = {}
	local cmdSetVehicle = {}
	local vehicleName = "Vehs_lvDOp_0000"

	for lrrpPlanName,routeTables in pairs(PURSUIT_GROUP_ROUTE) do
		cmdStartTravel 	= { id = "StartTravel", travelPlan=lrrpPlanName }

		if lrrpPlanName == "lrrp_from_DiamondOp" then
			vehicleName = "Vehs_lvDOp_0000"
		elseif lrrpPlanName == "lrrp_from_DiamondWest00" then
			vehicleName = "Vehs_lvDW_0000"
		else
			vehicleName = "Vehs_lvDW_0001"
		end

		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		cmdSetVehicle	= { id="SetRelativeVehicle", targetId=vehicleId }


		for i, routeTable in ipairs(routeTables) do
			for j,routeName in ipairs(routeTable) do

				local solName = this.routeNameChangeOneSolName(routeName)
				if solName then
					GameObject.SendCommand( solName, cmdStartTravel )
					GameObject.SendCommand( solName, cmdSetVehicle )
					break
				end
			end
		end
	end
end

this.hosWarp = function()

	
	local x = 657.46800000
	local y = 104.96620000
	local z = -1123.42600000
	local hosId = GameObject.GetGameObjectId( "hos_spy" )
	GameObject.SendCommand(hosId,{
			id="Warp",
			degRotationY = 0,
			position = Vector3(x,y,z),
			interpTime = 2,
	})
end

this.truckWarp = function()

	local vehicleId = GameObject.GetGameObjectId( "Vehs_truck_0000" )
	local x = 620.855774
	local y = 93.437553
	local z = -1109.254639
	local w = -1.170924782753

	GameObject.SendCommand( vehicleId, { id="SetPosition", position=Vector3(x,y,z), rotY=w, } )
	


end


this.WarpAccidentTruck =function()

	
	if not this.IsRealSpy() then
	
		
		this.truckWarp()
		
		this.DestroySpyVehicle()
		
		
		this.hosWarp()
	else
		
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", "Vehs_truck_0000")
		
		GameObject.SendCommand( vehicleId, { id="RequestToObserve", observation=bit.bor( Vehicle.observation.CRASH), } )
		
		
		GkEventTimerManager.Start( "DestroyTimer", DESTROY_TIME)
		
	end
	
end

this.IsRealSpy = function()
	local gameObjectId = GameObject.GetGameObjectId( "hos_spy" )
	local command = { id = "IsReal" }
	return GameObject.SendCommand( gameObjectId, command )
end


this.DestroySpyVehicle = function()

	
	
	
	local vehicleName = "Vehs_truck_0000"
	local vehicleId = GameObject.GetGameObjectId( "TppVehicle2", vehicleName )
	GameObject.SendCommand( vehicleId, { id="SetBodyLife", life=Vehicle.life.BROKEN, } )
	
end


this.SpyEscape = function()
	if svars.SpyStatus == s10081_sequence.SPY_STATUS.SPY_WAIT then
		TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_escape")
		svars.SpyStatus = s10081_sequence.SPY_STATUS.SPY_ESCAPE
	end
end

this.SpyAlert = function()
	TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_alert")
end

this.SpyHaven = function()
	TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_haven")
end


this.OnSpyFlag = function(hosId,state)

	local cmdHosState = {
			id = "SetHostage2Flag",
			flag = state, 	  
			on = true,
	}
	GameObject.SendCommand( hosId, cmdHosState )


end


this.SetUpSpy = function()
	TppEnemy.SetRescueTargets( {"hos_spy"} )

	local hosId = GameObject.GetGameObjectId("hos_spy")

	this.OnSpyFlag(hosId,"disableFulton")	
	this.OnSpyFlag(hosId,"disableScared")	


	
	local cmdHosFree = { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_FLEE }
	GameObject.SendCommand( hosId, cmdHosFree )
	
	
	local cmdCheckDistance = { id = "SetPlayerDistanceCheck", enabled=true, near=5, far=30 }
	GameObject.SendCommand( hosId, cmdCheckDistance )
	
end


this.SetKeepCaution = function()
	local Cps = {
					"mafr_diamondWest_ob",
					"mafr_bananaEast_ob",
					"mafr_banana_cp",
					"mafr_savannahNorth_ob",
				}

	for i,cpName in ipairs(Cps) do
		local cpId = GameObject.GetGameObjectId(cpName)
		local command = { id = "SetKeepCaution", enable=true }
		GameObject.SendCommand( cpId, command )
	end
end


this.SpyMonologue = function(labelName,isCarry)
	Fox.Log("__________s10081_enemy.SpyMonologue()  labelName is " .. tostring(labelName))
	local gameObjectId = GameObject.GetGameObjectId( "hos_spy" )
	local command = {
			id="CallMonologue",
			label = labelName,
			carry = isCarry,
	}
	GameObject.SendCommand( gameObjectId, command )
end




this.SetUpCorpse = function()
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "TppCorpseGameObjectLocator0000" ), { id = "ChangeFovaCorpse", faceId=EnemyFova.INVALID_FOVA_VALUE , bodyId=90  } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "TppCorpseGameObjectLocator0001" ), { id = "ChangeFovaCorpse", faceId=EnemyFova.INVALID_FOVA_VALUE , bodyId=91  } )
	
	local corpseIdAll = { type="TppCorpse", index=0 }	
	
	local corpseId = GameObject.GetGameObjectId( "TppCorpse", "TppCorpseGameObjectLocator0000" )
	local corpseId2 = GameObject.GetGameObjectId( "TppCorpse", "TppCorpseGameObjectLocator0001" )	
	



	
	
	
	
	local cmdBlood1 = { id = "SetBloodFaceMode", name = "TppCorpseGameObjectLocator0000", enabled=true }
	GameObject.SendCommand( corpseIdAll, cmdBlood1 )
	
	local cmdBlood2 = { id = "SetBloodFaceMode", name = "TppCorpseGameObjectLocator0001", enabled=true }
	GameObject.SendCommand( corpseIdAll, cmdBlood2 )
	
	local cmdInitMotion = { id = "SetInitMotion", path="/Assets/tpp/motion/SI_game/fani/bodies/enet/enetzmb/enetzmb_s_rag_ded_p_e.gani" }
	GameObject.SendCommand( corpseId, cmdInitMotion )
	local cmdKeepMotion = {id = "KeepInitMotion", enabled=true }
	GameObject.SendCommand( corpseId, cmdKeepMotion )
	
	
	local cmdInitMotion2 = { id = "SetInitMotion", path="/Assets/tpp/motion/SI_game/fani/bodies/enet/enetzmb/enetzmb_s_rag_ded_p_c.gani" }
	GameObject.SendCommand( corpseId2, cmdInitMotion2 )
	GameObject.SendCommand( corpseId2, cmdKeepMotion )
	
	

	
	
	




end

this.SetCorpseBlood = function()
	local corpseId = GameObject.GetGameObjectId( "TppCorpse", "TppCorpseGameObjectLocator0000" )
	local corpseId2 = GameObject.GetGameObjectId( "TppCorpse", "TppCorpseGameObjectLocator0001" )
	
	local cmdBloodStain1 = { id = "SetBloodStain", offsetPos=Vector3(0.25, 0, 0), radius=0.25 }
	local cmdBloodStain2 = { id = "SetBloodStain", offsetPos=Vector3(0.25, 0, 0), radius=0.25 }
	GameObject.SendCommand( corpseId, cmdBloodStain1 )
	GameObject.SendCommand( corpseId2, cmdBloodStain2 )
end




this.SetUpOB = function()
	local gameObjectId = GameObject.GetGameObjectId( "mafr_diamondOp_cp" )
	local command = { id = "SetOuterBaseCp" }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetUpLrrp = function()
	local gameObjectId = GameObject.GetGameObjectId( "mafr_pursuit_lrrp" )
	local command = { id = "SetLrrpCp" }
	GameObject.SendCommand( gameObjectId, command )
end




this.SetRouteSpGuardSol = function()
	Fox.Log("______s10081_enemy.SetRouteSpGuardSol()")
	TppEnemy.SetSneakRoute( "sol_diamondWest_0010" , "rts_diamondWest_sp_d_0000")
	TppEnemy.SetSneakRoute( "sol_diamondWest_0011" , "rts_diamondWest_sp_d_0001")

	TppEnemy.SetCautionRoute( "sol_diamondWest_0010" , "rts_diamondWest_sp_c_0000")
	TppEnemy.SetCautionRoute( "sol_diamondWest_0011" , "rts_diamondWest_sp_c_0000")
	
end

this.UnsetRouteSpGuardSol = function()
	Fox.Log("______s10081_enemy.UnsetRouteSpGuardSol()")
	TppEnemy.UnsetSneakRoute("sol_diamondWest_0010")
	TppEnemy.UnsetSneakRoute("sol_diamondWest_0011")
	TppEnemy.UnsetCautionRoute("sol_diamondWest_0010")
	TppEnemy.UnsetCautionRoute("sol_diamondWest_0011")
	
end





this.InterCall_Hostage = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10081_enemy.InterCall_Hostage()")
	TppMission.UpdateObjective{
		objectives = { "house_of_spy", nil },
	}
end




this.interrogation = {
	mafr_diamondWest_ob = {
		
		high = {
			{ name = "enqt1000_1i1210", func = this.InterCall_Hostage, },
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	nil
}

this.HighInterrogation = function()
	Fox.Log("*** HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "mafr_diamondWest_ob" ),
		{ 
			{ name = "enqt1000_1i1210", func = this.InterCall_Hostage, },
		
		}
	)
end

this.ResetHighInterrogation = function()
	Fox.Log("*** HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "mafr_diamondWest_ob" ),
		{ 		
		}
	)
end


this.useGeneInter = {
	mafr_savannahNorth_ob = true,	
	mafr_bananaEast_ob = true,
	mafr_diamondSouth_ob = true,
	mafr_diamondWest_ob = true,
	mafr_banana_cp = true,
	mafr_diamond_cp = true,
	nil
}





this.combatSetting = {

	
	mafr_diamondWest_ob = {
		"gts_diamondWest_0000",
		"css_diamondWest_0000",
	},
	mafr_diamondSouth_ob = {
		"gt_diamondSouth_0000",
	},
	mafr_bananaEast_ob = {
		"gt_bananaEast_0000",
	},
	mafr_savannahNorth_ob = {
		"gt_savannahNorth_0000",
	},
	
	mafr_banana_cp = {
		"gt_banana_0000",
		"cs_banana_0000",
	},
	mafr_diamond_cp = {
		"gt_diamond_0000",
		"cs_diamond_0000",
	},

	nil
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	TppEnemy.SetSneakRoute( "hos_spy" , "rts_spy_stand")
	this.SetUpSpy()
	this.SetUpCorpse()
	
	this.HighInterrogation()
	
	this.SetUpOB()
	this.SetUpLrrp()
	
	this.SetRouteSpGuardSol()	
	
end


this.OnLoad = function ()
	Fox.Log("*** s10081 onload ***")
end






return this
