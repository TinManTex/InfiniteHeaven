local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}
this.USE_COMMON_REINFORCE_PLAN = true	

local TORIMAKI_NAME_TABLE =  { 
	"sol_field_0000",
	"sol_field_0001",
	"sol_field_0002", 
}

local TORIMAKI_ROUTE_TABLE = {
	"rts_10036_0001",
	"rts_10036_0002",
	"rts_10036_0003",
}


local TORIMAKI_CP_ROUTE_TABLE = {
	"rts_10036_d_0001",
	"rts_10036_d_0002",
	"rts_10036_d_0003",
	"rts_10036_n_0001",
	"rts_10036_n_0002",
	"rts_10036_n_0003",
	"rts_10036_c_0001",
	"rts_10036_c_0002",
	"rts_10036_c_0003",
}





this.soldierDefine = {
	afgh_field_cp = {
		"sol_vip_0000",
		"sol_field_0003",
		"sol_field_0004",
		"sol_field_0005",
		"sol_field_0006",
		"sol_field_0007",
		"sol_field_0008",
		"sol_field_0009",
		"sol_field_0010",
		"sol_field_0013",
		
		
		
		"sol_field_1000",	
		
		nil
	},
	afgh_fieldEast_ob = {
		"sol_fieldEast_0000",
		"sol_fieldEast_0001",
		"sol_fieldEast_0002",
		nil
	},
	afgh_fieldWest_ob = {
		"sol_fieldWest_0000",
		"sol_fieldWest_0001",
		nil
	},
	
	afgh_16_29_lrrp = {
		"sol_29_16_0000",
		"sol_29_16_0001",
		lrrpTravelPlan = "travelField",
	},
	afgh_20_29_lrrp = {
		nil
	},
	
	afgh_10036_lrrp = {
		"sol_field_0000",	
		"sol_field_0001",	
		"sol_field_0002",	
		lrrpTravelPlan = "travelVip", 
		lrrpVehicle = "vhc_s10036_0000", 
		nil
	},
	nil
}





this.routeSets = {
	
	afgh_field_cp = {
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"vip",		
			"groupA",	
			"groupB",	
			"groupC",	
			"groupD",	
			nil
		},
		fixedShiftChangeGroup = {
			"vip",
		},
		sneak_day = {
			vip = {
				{ "rts_10036_d_0000", attr = "VIP" },
			},
		},
		sneak_night= {
			vip = {
				{"rts_10036_n_0000",attr = "VIP" },
			},
		},
		caution = {
			vip = {
				{"rts_10036_c_0000",attr = "VIP" },
			},
		},
		hold = {
			default = {
				{ "rts_10036_h_0000",attr = "VIP" },
				"rt_field_h_0000",
				"rt_field_h_0001",
				"rt_field_h_0002",
				"rt_field_h_0003",
			},
		},
		sleep = {
			default = {
				{ "rts_10036_s_0000",attr = "VIP" },
				"rt_field_s_0000",
				"rt_field_s_0001",
				"rt_field_s_0002",
				"rt_field_s_0003",
			},
		},
		travel = {
			lrrp_Vip_Hold = {
				"rts_10036_0001",
				"rts_10036_0002",
				"rts_10036_0003",
			},

		},
		nil
	},
	afgh_10036_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day 	= {	groupA = {}, },
		sneak_night = {	groupA = {}, },
		caution 	= {	groupA = {}, },
		hold 		= {	default = {}, },
		travel = {
			lrrp_16to29 = {
				"rts_vip_lrrp_0000",
				"rts_vip_lrrp_0000",
				"rts_vip_lrrp_0000",
			},
		},
		nil	
	},
	afgh_fieldEast_ob 	= { USE_COMMON_ROUTE_SETS = true,},
	afgh_fieldWest_ob 	= { USE_COMMON_ROUTE_SETS = true,},
	afgh_16_29_lrrp 	= {	USE_COMMON_ROUTE_SETS = true,},
	afgh_20_29_lrrp 	= { USE_COMMON_ROUTE_SETS = true,},
	nil
}


this.RouteSetsAfter = {
	afgh_field_cp = {
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"vip",		
			"groupA",	
			"groupB",	
			"groupC",	
			"groupD",	
			"near_vip",	
			nil
		},
		fixedShiftChangeGroup = {
			"vip",
			"near_vip",
		},
		sneak_day = {
			vip = {
				{ "rts_10036_d_0000", attr = "VIP" },
			},
			near_vip = {
				"rts_10036_d_0001",
				"rts_10036_d_0002",
				"rts_10036_d_0003",
			},
		},
		sneak_night= {
			vip = {
				{"rts_10036_n_0000",attr = "VIP" },
			},
			near_vip = {
				"rts_10036_n_0001",
				"rts_10036_n_0002",
				"rts_10036_n_0003",
			},
		},
		caution = {
			vip = {
				{"rts_10036_c_0000",attr = "VIP" },
			},
			near_vip = {
				"rts_10036_c_0001",
				"rts_10036_c_0002",
				"rts_10036_c_0003",
			},
		},
		hold = {
			default = {
				{ "rts_10036_h_0000",attr = "VIP" },
				"rt_field_h_0000",
				"rt_field_h_0001",
				"rt_field_h_0002",
				"rt_field_h_0003",
			},
		},
		sleep = {
			default = {
				{ "rts_10036_s_0000",attr = "VIP" },
				"rt_field_s_0000",
				"rt_field_s_0001",
				"rt_field_s_0002",
				"rt_field_s_0003",
			},
		},
		travel = {
			lrrp_Vip_Hold = {
				"rts_10036_0001",
				"rts_10036_0002",
				"rts_10036_0003",
			},

		},
		nil
	},
	afgh_10036_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day 	= {	groupA = {}, },
		sneak_night = {	groupA = {}, },
		caution 	= {	groupA = {}, },
		hold 		= {	default = {}, },
		travel = {
			lrrp_16to29 = {
				"rts_vip_lrrp_0000",
				"rts_vip_lrrp_0000",
				"rts_vip_lrrp_0000",
			},
		},
		nil	
	},
}





this.cpGroups = {
	group_Area1 = {
		
		"afgh_field_cp",

		
		"afgh_fieldEast_ob",
		"afgh_fieldWest_ob",

		
		"afgh_16_29_lrrp",
		"afgh_20_29_lrrp",
	},
}





this.combatSetting = {
	afgh_field_cp = {
		"gt_field_0000",
		"cs_field_0000",
	},
	afgh_fieldEast_ob = {
		"gt_fieldEast_0000",
		"cs_fieldEast_0000",
	},
	afgh_fieldWest_ob = {
		"gt_fieldWest_0000",
		"cs_fieldWest_0000",
	},
	nil
}





this.lrrpHoldTime = 5

this.travelPlans = {
	travelField = {
		{ base = "afgh_fieldEast_ob" },
		{ base = "afgh_field_cp" },
		{ base = "afgh_fieldWest_ob" },
		{ base = "afgh_field_cp" },
	},
	travelVip = {
		ONE_WAY = true,
		{ cp="afgh_10036_lrrp", 		routeGroup={ "travel", "lrrp_16to29" } },
		{ cp="afgh_field_cp", 			routeGroup={ "travel", "lrrp_Vip_Hold" } },
	},
}

this.soldierPowerSettings = {
    sol_vip_0000 = { },
}






this.UniqueInterEnd_sol_vip_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : End")
	
end

this.UniqueInterStart_sol_vip_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : start "..svars.vipJinmonNum )
	
	svars.vipJinmonNum = svars.vipJinmonNum + 1
	if svars.vipJinmonNum > 5 then 
		svars.vipJinmonNum = 5
	end

	if svars.vipJinmonNum == 1 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_1y1a10") 
	elseif svars.vipJinmonNum == 2 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_1z1a10")
	elseif svars.vipJinmonNum == 3 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_201a10")
	elseif svars.vipJinmonNum == 4 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_211a10")
	else
		return false
	end

	return true
end

this.uniqueInterrogation = {
	unique = {
		{ name = "enqt1000_1y1a10", func = this.UniqueInterEnd_sol_vip_0000, },
		{ name = "enqt1000_1z1a10", func = this.UniqueInterEnd_sol_vip_0000, },
		{ name = "enqt1000_201a10", func = this.UniqueInterEnd_sol_vip_0000, },
		{ name = "enqt1000_211a10", func = this.UniqueInterEnd_sol_vip_0000, },
		nil
	},
	uniqueChara = {
		{ name = "sol_vip_0000", func = this.UniqueInterStart_sol_vip_0000, },
		nil
	},
	nil
}




this.useGeneInter = {
	afgh_field_cp = true,	
	afgh_fieldEast_ob = true,
	afgh_fieldWest_ob = true,
	nil
}

this.InterCall_TargetPlace = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("int: vip is here. soldierId : "..soldier2GameObjectId )
	
	
	TppMission.UpdateObjective{
		objectives = { "marker_area_vip", nil },
	}
end
this.InterCall_Shigen = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{
		objectives = { "on_itm_s10036_material", nil },
	}
end
this.InterCall_Herb = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{
		objectives = { "on_itm_s10036_herb", nil },
	}
end

this.interrogation = {
	
	afgh_field_cp = {
		high = {
			{ name = "enqt3000_151010", func = this.InterCall_TargetPlace, },
			{ name = "enqt1000_1f1l11", func = this.InterCall_Shigen, },
			nil
		},
		normal = {
			nil
		},
		nil
	},
	afgh_fieldEast_ob = {
		high = {
			{ name = "enqt1000_101524", func = this.InterCall_Herb, },
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
		GameObject.GetGameObjectId( "afgh_field_cp" ),
		{ 
			{ name = "enqt3000_151010", func = this.InterCall_TargetPlace, },
			{ name = "enqt1000_1f1l11", func = this.InterCall_Shigen, },
		}
	)
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "afgh_fieldEast_ob" ),
		{ 
			{ name = "enqt1000_101524", func = this.InterCall_Herb, },
		}
	)
end

this.RemoveInterrogation = function()
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_field_cp" ),
		{ 
			{ name = "enqt3000_151010", func = this.InterCall_TargetPlace, },
		}
	)
end



this.SetVip = function()
	Fox.Log("Set vip enemy")
	TppEnemy.SetEliminateTargets( { "sol_vip_0000" } )

	Fox.Log("Initialize route set group,vip and near vip enemyes")
	TppEnemy.InitialRouteSetGroup{
        cpName = "afgh_field_cp",
        soldierList = { "sol_vip_0000", },
        groupName = "vip",
	}
	local gameObjectId = GameObject.GetGameObjectId( "sol_vip_0000" )
	GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", "ene_c" } )
	







end


this.CallTalkEnemy = function( enemyId, label)
	if enemyId == nil then
		Fox.Error("enemyid is nil")
	end
	
	if label == nil then
		Fox.Error("label is nil")
	end
	
	Fox.Log("func:CallTalkEnemy")
	local gameObjectId
	if Tpp.IsTypeString( enemyId ) then
		gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyId )
	else
		gameObjectId = enemyId
	end
	
	local lifeState = GameObject.SendCommand( gameObjectId, { id = "GetLifeStatus" } )
	if lifeState ~= TppGameObject.NPC_LIFE_STATE_DEAD then
		Fox.Log("call converstion "..label)
		local command = {
			id = "CallMonologue",
			label = label,
		}
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("dont call converstion. enemy dead ")
	end
end


this.StopCpChat = function(enable)
	local flag = false
	if enable == true then
		flag = true
	end
	local gameObjectId = { type="TppCommandPost2" }
	local command = { id="SetChatEnable", enabled=flag }
	GameObject.SendCommand( gameObjectId, command )
end

this.TalkStart = function()
	this.CallTalkEnemy("sol_vip_0000", "VIP_001")
end

this.TalkEnd = function()
	this.CallTalkEnemy("sol_vip_0000", "VIP_END")
end




local spawnList = {
	{ id="Spawn", locator="vhc_s10036_0000", type=Vehicle.type.EASTERN_LIGHT_VEHICLE, },
}
this.vehicleDefine = {
        instanceCount   = #spawnList + 1,
}

this.SpawnVehicleOnInitialize = function()
	
	TppEnemy.SpawnVehicles( spawnList )
end


this.InitEnemy = function ()
	

	TppEnemy.SetEliminateTargets( {"sol_vip_0000"} )

end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	TppEnemy.AssignUniqueStaffType{
	        locaterName = "sol_vip_0000",
	        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10036_COMMANDER,
	        alreadyExistParam  = { staffTypeId =2, randomRangeId =6, skill ="Reflex" },
	}

	this.SetVip()
	
	this.HighInterrogation()

	
	local vehicleId = GameObject.GetGameObjectId( "vhc_s10036_0000" )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=true }
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", TORIMAKI_NAME_TABLE[1] ), command )
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", TORIMAKI_NAME_TABLE[2] ), command )
	GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", TORIMAKI_NAME_TABLE[3] ), command )

end


this.OnLoad = function ()
	Fox.Log("*** s10036 onload ***")

end

this.ChangeRouteSetsVIP = function()
		Fox.Log("ser route.VIP line")
		
		TppEnemy.SetSneakRoute( "sol_vip_0000", 	"rts_10036_0000", nil, { isRelaxed=true } )	

end


this.resetRouteSetsVIP = function()
		Fox.Log("reset route. becouse Player enter trap")
		TppEnemy.UnsetSneakRoute( "sol_vip_0000" )	

		TppEnemy.ChangeRouteSets( this.RouteSetsAfter )
		TppEnemy.InitialRouteSetGroup{
	        cpName = "afgh_field_cp",
	        soldierList = { "sol_vip_0000", },
	        groupName = "vip",
		}

		GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", TORIMAKI_NAME_TABLE[1] ), { id="SetCommandPost", cp="afgh_field_cp" } )
		GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", TORIMAKI_NAME_TABLE[2] ), { id="SetCommandPost", cp="afgh_field_cp" } )
		GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", TORIMAKI_NAME_TABLE[3] ), { id="SetCommandPost", cp="afgh_field_cp" } )

		
		TppEnemy.InitialRouteSetGroup{
	        cpName = "afgh_field_cp",
	        soldierList = TORIMAKI_NAME_TABLE,
	        groupName = "near_vip",
		}

		local soldiers
		for i, route in ipairs(TORIMAKI_ROUTE_TABLE) do
				soldiers = GameObject.SendCommand( { type="TppSoldier2" }, { id="GetGameObjectIdUsingRoute", route=route } )
				Fox.Log("route = "..route..", soldier num = "..#soldiers)

				for i, soldierName in ipairs(soldiers)do
					TppEnemy.UnsetSneakRoute( soldierName )
				end
		end

end





return this
