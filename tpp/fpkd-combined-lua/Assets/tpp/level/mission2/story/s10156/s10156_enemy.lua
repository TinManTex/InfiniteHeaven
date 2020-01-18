local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}









this.USE_COMMON_REINFORCE_PLAN = true



this.NOTALKINGLIST= {
		"sol_Ruins_0000",
		"sol_Ruins_0001",
		"sol_Ruins_0002",
		"sol_Ruins_0003",
		"sol_Ruins_0004",
		"sol_Ruins_0005",
		"sol_Reinforce_0001",
		"sol_Reinforce_0002",
		"sol_Reinforce_0003",
		"sol_fieldEast_0001",
		"sol_fieldEast_0002",
}





this.soldierDefine = {

	
	
	afgh_Ruins_cp = {
		"sol_Ruins_0000",
		"sol_Ruins_0001",
		"sol_Ruins_0002",
		"sol_Ruins_0003",
		"sol_Ruins_0004",
		"sol_Ruins_0005",
		nil
	},

	afgh_villageEast_ob = {
		"sol_villageEast_0000",
		"sol_Reinforce_0001",
		"sol_Reinforce_0002",
		"sol_Reinforce_0003",
		"sol_villageEast_0001",
		"sol_villageEast_0002",
		"sol_villageEast_0003",
		"sol_villageEast_0004",
		nil
	},
	afgh_fieldEast_ob = {
		"sol_fieldEast_0000",
		"sol_fieldEast_0001",
		"sol_fieldEast_0002",
		"sol_fieldEast_0003",
		"sol_fieldEast_0004",
		nil
	},
	afgh_ruinsNorth_ob = {
		"sol_ruinsNorth_0000",
		"sol_ruinsNorth_0001",
		"sol_ruinsNorth_0002",
		"sol_ruinsNorth_0003",
		"sol_ruinsNorth_0004",
		nil
	},











	afgh_Travel_cp_01 = {
		nil
	},
	afgh_Travel_cp_02 = {
		nil
	},
	afgh_Travel_cp_03 = {
		nil
	},
	nil
}



this.soldierPowerSettings = {
	sol_Ruins_0003 = { "SHOTGUN", "ARMOR", },
	sol_Ruins_0004 = { "SHOTGUN", "ARMOR", },
	sol_Reinforce_0001 = { "MG", "ARMOR", },
}





local spawnList = {
	{ id="Spawn", locator="veh_North_0000",	type=Vehicle.type.EASTERN_LIGHT_VEHICLE, },
	{ id="Spawn", locator="veh_West_0000",		type=Vehicle.type.EASTERN_LIGHT_VEHICLE, },
}

this.vehicleDefine = {
	instanceCount	= #spawnList + 1,	
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( spawnList )
end





this.routeSets = {

	
	afgh_Ruins_cp = {
		
		
		
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
		},
		fixedShiftChangeGroup = {
			"groupSniper",	
		},
		sneak_day = {
			groupSniper = {
				{ "rts_ruins_snp_0000", attr = "SNIPER" },
				{ "rts_ruins_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_Ruins_d_0000",
				"rts_Ruins_d_0002",
				"rts_Ruins_d_0005",
				"rts_Ruins_d_0004",
				"rts_Ruins_d_0007",
				"rts_Ruins_d_0010",
				"rts_Ruins_d_0012",
			},
			groupB = {
				"rts_Ruins_d_0001",
				"rts_Ruins_d_0003",
				"rts_Ruins_d_0008",
				"rts_Ruins_d_0006",
				"rts_Ruins_d_0009",
				"rts_Ruins_d_0011",
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rts_ruins_snp_0000", attr = "SNIPER" },
				{ "rts_ruins_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_Ruins_0000",
				"rts_Ruins_0002",
				"rts_Ruins_0005",
				"rts_Ruins_0007",
				"rts_Ruins_0008",
				"rts_Ruins_0010",
				"rts_Ruins_0012",
			},
			groupB = {
				"rts_Ruins_0001",
				"rts_Ruins_0003",
				"rts_Ruins_0006",
				"rts_Ruins_0004",
				"rts_Ruins_0009",
				"rts_Ruins_0011",
			},
		},
		caution = {
			groupSniper = {
				{ "rts_ruins_snp_0000", attr = "SNIPER" },
				{ "rts_ruins_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_Ruins_d_0000",
				"rts_Ruins_d_0001",
				"rts_Ruins_d_0002",
				"rts_Ruins_caution_0003",
				"rts_Ruins_caution_0004",
				"rts_Ruins_caution_0005",
				"rts_Ruins_caution_0006",
				"rts_Ruins_caution_0007",
				"rts_Ruins_caution_0008",
				"rts_Ruins_caution_0009",
				"rts_Ruins_d_0004",
				"rts_Ruins_caution_0010",
				"rts_Ruins_caution_0011",
			},
			groupB = {
			},
		},
		hold = {
			
			
			default = {
			},
		},
		nil
	},

	
	afgh_ruinsNorth_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rt_ruinsNorth_d_0000",
				"rt_ruinsNorth_d_0001",
				"rt_ruinsNorth_d_0002",
				"rts_ruinsNorth_d_0003",
				"rts_ruinsNorth_d_0004",
			},
		},
		sneak_night = {
			groupA = {
				"rt_ruinsNorth_n_0000",
				"rt_ruinsNorth_n_0001",
				"rt_ruinsNorth_n_0002",
				"rts_ruinsNorth_n_0003",
				"rts_ruinsNorth_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_ruinsNorth_c_0000",
				"rt_ruinsNorth_c_0001",
				"rt_ruinsNorth_c_0002",
				"rt_ruinsNorth_c_0003",
				"rt_ruinsNorth_c_0004",
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_ruinsNorth_s_0000",
				"rt_ruinsNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_ruinsNorth_l_0000",
				"rt_ruinsNorth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_ruinsNorth_lin_N",
				"rt_ruinsNorth_lin_N",
			},
			out_lrrpHold_N = {
				"rt_ruinsNorth_lout_N",
				"rt_ruinsNorth_lout_N",
			},
			in_lrrpHold_S = {
				"rt_ruinsNorth_lin_S",
				"rt_ruinsNorth_lin_S",
			},
			out_lrrpHold_S = {
				"rt_ruinsNorth_lout_S",
				"rt_ruinsNorth_lout_S",
			},
		},
		outofrain = {
			"rt_ruinsNorth_r_0000",
		},
		nil
	},


	
	afgh_Travel_cp_01 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
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
			
			
			groupA = {
				"First_Car",
				"First_Car",
				"First_Car",
			},
		},
		nil
	},

	
	afgh_Travel_cp_02 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
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
			
			
			groupA = {
				"Second_Car",
				"Second_Car",
			},
		},
		nil
	},

	
	afgh_Travel_cp_03 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
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
			
			
			groupA = {
				"rts_Final_Reinforce",
				"rts_Final_Reinforce",
			},
		},
		nil
	},

	
	afgh_villageEast_ob		 	= { USE_COMMON_ROUTE_SETS = true,	},
	afgh_fieldEast_ob		 	= { USE_COMMON_ROUTE_SETS = true,	},

	
	
	nil
}





this.combatSetting = {

	afgh_Ruins_cp = {
		"Ruins_TppCombatLocatorSetData",
		"Ruins_TppGuardTargetData",
	},

	
	afgh_villageEast_ob = {
		"gt_villageEast_0000",
	},
	afgh_ruinsNorth_ob = {
		"gt_ruinsNorth_0000",
	},
	afgh_fieldEast_ob = {
		"gt_fieldEast_0000",
	},

	nil
}





this.InterCall_FirstTime = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10156_enemy.InterCall_FirstTime()")

end

this.InterCall_SubTaskTarget = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10156_enemy.InterCall_FirstTime()")
	TppMission.UpdateObjective{
		objectives = {"interrogation_on_HiddenHostage",},				
	}
	TppRadio.Play( "f1000_esrg0790",{delayTime = "mid", isEnqueue = true } )
end


this.InterCall_LastTime = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10156_enemy.InterCall_LastTime()")
end




this.interrogation = {
	
	afgh_Ruins_cp = {
		
		high = {
			{ name = "enqt1000_106916", func = this.InterCall_FirstTime, },	
			{ name = "enqt1000_1i1210", func = this.InterCall_SubTaskTarget, },	
			{ name = "enqt1000_1x1a10", func = this.InterCall_LastTime, },	
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
	Fox.Log("###*** SetUp_HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "afgh_Ruins_cp" ),
		{
			{ name = "enqt1000_106916", func = this.InterCall_FirstTime, },
			{ name = "enqt1000_1i1210", func = this.InterCall_SubTaskTarget, },	
			{ name = "enqt1000_1x1a10", func = this.InterCall_LastTime, },	
		}
	)
end


this.RemoveHighInterrogation01 = function()
	Fox.Log("###*** s10156_enemy.RemoveHighInterrogation01 ***")
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_Ruins_cp"),
	{
		{ name = "enqt1000_1i1210", func = s10156_enemy.InterCall_SubTaskTarget, },
	})
end



this.useGeneInter = {
	
	afgh_villageEast_ob		= true,
	afgh_ruinsNorth_ob		= true,
	afgh_fieldEast_ob		= true,
	nil
}




this.travelPlans = {
		Travel_First_Car = {
			ONE_WAY = true,
			{ cp = "afgh_Travel_cp_01", routeGroup={ "travel", "groupA" } },
			{ cp = "afgh_Ruins_cp", finishTravel=true },
		},

		Travel_Second_Car = {
			ONE_WAY = true,
			{ cp = "afgh_Travel_cp_02", routeGroup={ "travel", "groupA" } },
			{ cp = "afgh_Ruins_cp", finishTravel=true },
		},


		Travel_Final_Reinforce = {
			ONE_WAY = true,
			{ cp = "afgh_Travel_cp_03", routeGroup={ "travel", "groupA" } },
			{ cp = "afgh_Ruins_cp", finishTravel=true },
		},
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	






	
	local obSetCommand = { id = "SetMarchCp" }
	GameObject.SendCommand( GameObject.GetGameObjectId( "afgh_Travel_cp_01" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "afgh_Travel_cp_02" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "afgh_Travel_cp_03" ) , obSetCommand )

	TppEnemy.RegisterCombatSetting( this.combatSetting )

	


	
	this.SetAllEnemyStaffParam()

	
	this.SetUpHostageLanguage()
	
	this.HighInterrogation()

	
	
	local targetList = {
		"hos_s10156_0000",
	}
	this.RegistHoldRecoveredStateForMissionTask( targetList )


end


this.OnLoad = function ()
	Fox.Log("*** s10156 onload ***")
end








this.SetAllEnemyStaffParam = function ()
	Fox.Log("#### s10156_enemy.SetAllStaffParam ####")
	TppEnemy.AssignUniqueStaffType{
		locaterName = "hos_s10156_0000",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10156_HOSTAGE,		
		alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="SuppressorEngineer" },
	}
end



this.SetUpHostageLanguage = function ()
	Fox.Log("###***SetUpLanguage_for_Hostage! ENGLISH ####")
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10156_0000" )
	local setLanguage = { id = "SetLangType", langType="russian" }
	

	GameObject.SendCommand( gameObjectId, setLanguage )
	

end


this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end


this.SetAllEnemyOnVehicle = function()
	Fox.Log( "*****s10156_enemy.SetAllEnemyOnVehicle***")

	local soldierName = "sol_Reinforce_0001"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_North_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_Reinforce_0002"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_North_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_Reinforce_0003"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_North_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )



	local soldierName = "sol_fieldEast_0001"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_West_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_fieldEast_0002"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_West_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

end




this.Reinforce01RouteSet = function()
	TppEnemy.SetSneakRoute( "sol_Reinforce_0001", "rts_Reinforce_d_0001" )
	TppEnemy.SetSneakRoute( "sol_Reinforce_0002", "rts_Reinforce_d_0002" )
	TppEnemy.SetSneakRoute( "sol_Reinforce_0003", "rts_Reinforce_d_0003" )


	TppEnemy.SetCautionRoute( "sol_Reinforce_0001", "rts_Reinforce_caution_0001" )
	TppEnemy.SetCautionRoute( "sol_Reinforce_0002", "rts_Reinforce_caution_0002" )
	TppEnemy.SetCautionRoute( "sol_Reinforce_0003", "rts_Reinforce_caution_0003" )
end


this.CheckAliveEnemy = function( cpName )
	Fox.Log("!!!! s10156_enemy.CheckAliveEnemy !!!!"..cpName)

	if cpName == nil then
		return nil
	end

	for index, soldierName in pairs(mvars.ene_soldierDefine[cpName]) do
		if soldierName then
			if TppEnemy.GetLifeStatus( soldierName ) == TppEnemy.LIFE_STATUS.NORMAL then
				Fox.Log("!!!! s10156_enemy.CheckAliveEnemy return !!!!"..soldierName)
				return soldierName
			end
		end
	end

	Fox.Log("!!!! s10156_enemy.CheckAliveEnemy ->NoAliveEnemy !!!!")

end


this.CheckRouteAndCancel = function( routeName )
	Fox.Log("!!!! s10156_enemy.CheckRouteAndCancel !!!!"..routeName)

	if routeName == nil then
		return
	end

	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )
	Fox.Log( #soldiers )
	for i, soldier in ipairs(soldiers) do
		Fox.Log( string.format("0x%x", soldier) )
		GameObject.SendCommand( soldier, { id = "SetSneakRoute", route = "" } )	
		GameObject.SendCommand( soldier, { id = "SetCautionRoute", route = "" } )	
	end

end



function this.DisableOccasionalChat()
	Fox.Log("***###s10156_enemy.DisableOccasionalChat###")
	for i, soldierName in ipairs(this.NOTALKINGLIST) do

		local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", soldierName )
		local command = { id="SetDisableOccasionalChat", disable=true }
		GameObject.SendCommand( gameObjectId, command )
	end
end


this.SetUpRatRoute = function ( locatorName, routeName )

	local gameObjectId = {type="TppRat", group=0, index=0}
	local command = {
			id="SetRoute",
			name=locatorName, 
			route=routeName 	
	}
	GameObject.SendCommand( gameObjectId, command )
end


this.CPRadioTargetDiscovered = function( gameObjectId )
	Fox.Log("***###s10156_enemy.CPRadioTargetDiscovered###")
	local command = { id="CallRadio", label="CPRSP030", stance="Squat", voiceType="ene_a" }	
	GameObject.SendCommand( gameObjectId, command )
end




return this
