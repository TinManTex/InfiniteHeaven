local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}






this.soldierDefine = {}




this.soldierSubTypes = {}


this.routeSets = {}


this.GetRouteSetPriority = nil


this.combatSetting = {}

this.soldierPowerSettings = {}


this.TARGET_ENEMY = {}

this.TARGET_ENEMY_STAFFID = 40




this.HOSTAGELIST = {}

this.HOSTAGELIST_FULL = {
	"hos_s10115_0000",
	"hos_s10115_0001",
	"hos_s10115_0002",
	"hos_s10115_0003",
	"hos_s10115_0004",
	"hos_s10115_0005",
}





this.HELI_LIST = {
	"WestHeli0000",
	"WestHeli0001",
	"WestHeli0002",
}











this.HasMosquito = function ()
	Fox.Log("#### HasMosquito ####")
	
	if TppMotherBaseManagement.IsExistStaff{ uniqueTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10115_MOSQUITO } then
		Fox.Log("#### You have MOSQUITO")
		return true
	else
		Fox.Log("#### You don't have MOSQUITO")
		return false
	end
end

 
 


this.isEmiliatedAllEnemy = function ( soldierList )
	Fox.Log("#### s10115_enemy.isEmiliatedAllEnemy ####")

	
	for idx = 1, table.getn(soldierList) do
		if TppEnemy.IsEliminated( soldierList[idx] ) == false then
			return false
		end
	end
	return true
end


 
this.killHostage = function ( soldierName, hostageName )
	Fox.Log("#### s10115_enemy.killHostage ####" .. hostageName)
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local hostageId = GameObject.GetGameObjectId("TppHostage2", hostageName )

	
	local command = { id="SetExecuteHostage", targetId=hostageId }
	GameObject.SendCommand( soldierId, command )

end





this.SetEnemyLocationType = function()
	Fox.Log("#### s10115_enemy.SetEnemyLocationType ####")

	
	if EnemyType ~= nil then
		local gameObjectId = { type="TppSoldier2" } 
		local command = { id = "SetSoldier2Type", type = EnemyType.TYPE_DD }
		GameObject.SendCommand( gameObjectId, command )
	end
	
	if CpType ~= nil then
		local gameObjectId = { type="TppCommandPost2" } 
		local command = { id = "SetCpType", type = CpType.TYPE_AMERICA }
		GameObject.SendCommand( gameObjectId, command )
	end
end


 
 




this.SetUpHostage = function (hostageList)
	
	for idx = 1, table.getn(this.HOSTAGELIST_FULL) do
		local gameObjectId = GameObject.GetGameObjectId( this.HOSTAGELIST_FULL[idx] )
		local command = { id="SetEnabled", enabled=false }
		GameObject.SendCommand( gameObjectId, command )
	end

	
	
	
	for idx = 1, table.getn(hostageList) do
		local gameObjectId = GameObject.GetGameObjectId( hostageList[idx] )
		local command = { id="SetEnabled", enabled=true }
		GameObject.SendCommand( gameObjectId, command )

		TppEnemy.RegistHoldRecoveredState( hostageList[idx] )
	end


end

 
this.SetTargetFova = function(targetName)
	Fox.Log("#### s10115_enemy.SetTargetFova targetName :: " .. tostring(targetName))
	
	local gameObjectId = { type="TppSoldier2" }
	local command = { id = "ChangeFova", balaclavaFaceId=EnemyFova.NOT_USED_FOVA_VALUE ,bodyId=140 }
	GameObject.SendCommand( gameObjectId, command )
	
	
	
	gameObjectId = GameObject.GetGameObjectId( targetName )
	command = { id = "ChangeFova", faceId=8, balaclavaFaceId=EnemyFova.NOT_USED_FOVA_VALUE ,bodyId=141 }
	GameObject.SendCommand( gameObjectId, command )

	
	
	TppEnemy.AssignUniqueStaffType{
		locaterName = targetName,
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10115_MOSQUITO,
		alreadyExistParam = { staffTypeId =41, randomRangeId =4, skill ="BigMouth" },
	}
end


this.SetTargetEquip = function(targetName)
	Fox.Log("#### s10115_enemy.SetTargetEquip targetName::" .. tostring(targetName))
	
	
	if this.HasMosquito() == true then
		Fox.Log("#### s10115_enemy.SetTargetEquip Set Special ###")
		this.soldierPowerSettings = {
			[targetName] = { "MISSILE" },
		}
	else
		Fox.Log("#### s10115_enemy.SetTargetEquip Set Normal ###")
		this.soldierPowerSettings = {}
	end
end



 

this.AppearClearHeli = function ( routeList )
	Fox.Log("#### s10115_enemy.AppearClearHeli ####")
	for idx = 1, table.getn(this.HELI_LIST) do
		local heliObjectId = GameObject.GetGameObjectId(this.HELI_LIST[idx])
		local routeId = routeList[idx]
		Fox.Log("#### heliObjectId ####"..heliObjectId.."routeId"..routeId)
		GameObject.SendCommand( heliObjectId, { id = "SetForceRoute", route = routeId })
		GameObject.SendCommand( heliObjectId, { id = "SetEnabled", enabled = true })
	end
end








this.AdmonishEnemy = function ( soldierList )
	Fox.Log("#### s10115_enemy.AdmonishEnemy ####")
	
	local commandHoldUp = { id="SetForceHoldup" }

	for i,key in ipairs(soldierList) do
		local soldierName = soldierList[i]
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		
		if TppEnemy.IsNeutralized(soldierName) == false then
			
			Fox.Log("#### HoldUp ENEMY :".. soldierName ..	"####")
			GameObject.SendCommand( soldierId, commandHoldUp )
		end
	end
end








this.isLastHostage = function (hostageList)
	Fox.Log("#### s10115_enemy.isLastHostage ####")
	local count_gone_hostage = mvars.numHostageKilled + mvars.numHostageRecovered
	
	if (#hostageList - count_gone_hostage) == 1 then
		return true
	else
		return false
	end
end












this.isAllHostageRecovered = function (hostageList)
	Fox.Log("#### s10115_enemy.isAllHostageRecovered ####")
	for idx = 1, table.getn(hostageList) do
		if TppEnemy.IsRecovered( hostageList[idx] ) == false then
			return false
		end
	end
	return true
end








this.isAllHostageKilled = function (hostageList)
	Fox.Log("#### s10115_enemy.isAllHostageKilled ####")
	for idx = 1, table.getn(hostageList) do
		local gameObjectId = GameObject.GetGameObjectId( "TppHostage2", hostageList[idx] )
		local command = { id = "GetLifeStatus" }
		local lifeState = GameObject.SendCommand( gameObjectId, command )
		if lifeState ~= TppGameObject.NPC_LIFE_STATE_DEAD then
			return false
		end
	end
	return true
end

this.SetCPIgnoreHeli = function (switch)
	local command = {}
	if switch == true then
		command = { id = "SetIgnoreLookHeli" }
	else
		command = { id = "RemoveIgnoreLookHeli" }
	end
	local cpId = { type="TppCommandPost2" } 
	GameObject.SendCommand( cpId, command )
end







this.UniqueInterStart_target = function( soldier2GameObjectId, cpID )
	Fox.Log("______________s10115_enemy.UniqueInterStart_target  / CallBack : Unique : start")
	Fox.Log("mvars.targetInterCount : "..mvars.targetInterCount )

	if mvars.targetInterCount == 0 then
		Fox.Log("A")
		TppInterrogation.UniqueInterrogation( cpID, "enqt3000_161010")
	elseif mvars.targetInterCount == 1 then
		Fox.Log("B")
		TppInterrogation.UniqueInterrogation( cpID, "enqt3000_171010")
	elseif mvars.targetInterCount >= 2 then
		Fox.Log("C")
		TppInterrogation.UniqueInterrogation( cpID, "enqt3000_181010")
	end
	return true

end

this.UniqueInterEnd_target = function( soldier2GameObjectId, cpID )
	Fox.Log("______________s10115_enemy.UniqueInterEnd_target  / CallBack : Unique : End")
	mvars.targetInterCount = mvars.targetInterCount +1
end

this.uniqueInterrogation = {
	unique = {
		{ name = "enqt3000_161010", func = this.UniqueInterEnd_target, },
		{ name = "enqt3000_171010", func = this.UniqueInterEnd_target, },
		{ name = "enqt3000_181010", func = this.UniqueInterEnd_target, },
		nil
	},
	uniqueChara = {
		{ name = "ly003_cl02_10115_npc0000|cl02pl0_uq_0020_npc|sol_plnt0_0000", func = this.UniqueInterStart_target, },
		nil
	},
	nil
}



this.interrogation = {
}


this.useGeneInter = {
	nil
}

this.InterCall_Hostage = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10115_enemy.InterCall_Hostage()")
	TppMission.UpdateObjective{
		objectives = { "bonus_Hostage", nil },
	}
end

this.InterCall_HostagePlant2 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10115_enemy.InterCall_Hostage()")
	TppMission.UpdateObjective{
		objectives = { "bonus_Hostage_plant2", nil },
	}
end

this.InterCall_HostagePlant0Detail = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10115_enemy.InterCall_HostagePlant0Detail()")
	TppMission.UpdateObjective{
		objectives = { "bonus_Hostage_0", "bonus_Hostage_1", "bonus_Hostage_2"},
	}
end

this.InterCall_HostagePlant2Detail = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10115_enemy.InterCall_HostagePlant2Detail()")
	TppMission.UpdateObjective{
		objectives = { "bonus_Hostage_3", "bonus_Hostage_4", "bonus_Hostage_5"},
	}
end

this.InterCall_Boss = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("_________s10115_enemy.InterCall_Boss()")
	if mvars.isMarkedTarget ~= true then
		mvars.isMarkedTargetByIntel = true
		TppMission.UpdateObjective{
			objectives = { "target_area", nil },
		}
	end
end


 
this.INTER_HOSTAGE_PLNT0 = { name = "enqt3000_141010", func = this.InterCall_HostagePlant0Detail, }
this.INTER_HOSTAGE_PLNT2 = { name = "enqt3000_141010", func = this.InterCall_HostagePlant2Detail, }
this.INTER_BOSS = { name = "enqt3000_151010", func = this.InterCall_Boss, }








this.InitEnemy = function ()
	Fox.Log("*** s10115 InitEnemy ***")
	
	
	
	local clusterId = 2 + 1
	if not clusterId then
		Fox.Error("clusterId is nil")
	end
	mtbs_enemy.useUiSetting = false					
	mtbs_enemy.InitEnemy(clusterId)

	
	this.interrogation = {
		
		[mtbs_enemy.cpNameDefine]= {
			high = {
				this.INTER_HOSTAGE_PLNT2,
				this.INTER_BOSS,
				nil
			},
			nil
		},
		nil
	}
end



this.SetUpEnemy = function ()
	
	
	
	
	local clusterId = 2 + 1
	mtbs_enemy.useUiSetting = false					
	Fox.Log("*** s10115enemy.SetUpEnemy ::ClusterID = ***"..clusterId)
	mtbs_enemy.SetupEnemy( clusterId )

	
	local gameObjectId = { type="TppCommandPost2" } 
	local combatAreaList = {
		area1 = {
			{ guardTargetName = mtbs_enemy.plnt0_gtNameDefine, locatorSetName = mtbs_enemy.plnt0_cbtSetNameDefine,}, 
		},
		area2 = {
			{ guardTargetName = mtbs_enemy.plnt1_gtNameDefine, locatorSetName = mtbs_enemy.plnt1_cbtSetNameDefine,}, 
		},
		area3 = {
			{ guardTargetName = mtbs_enemy.plnt2_gtNameDefine, locatorSetName = mtbs_enemy.plnt2_cbtSetNameDefine,}, 
		},
		area4 = {
			{ guardTargetName = mtbs_enemy.plnt3_gtNameDefine, locatorSetName = mtbs_enemy.plnt3_cbtSetNameDefine,}, 
		},
	}
	local command = { id = "SetCombatArea", cpName = mtbs_enemy.cpNameDefine, combatAreaList = combatAreaList }
	GameObject.SendCommand( gameObjectId, command )

	local command = { id = "SetIgnoreReinforce" }
	GameObject.SendCommand( gameObjectId, command )


	TppEnemy.SetSneakRoute( this.TARGET_ENEMY.NAME, this.TARGET_ENEMY.ROUTE_SNEAK )	
	TppEnemy.SetCautionRoute( this.TARGET_ENEMY.NAME, this.TARGET_ENEMY.ROUTE_CAUTION)
	TppEnemy.SetEliminateTargets( {this.TARGET_ENEMY.NAME,} )	


	
	this.SetTargetFova(this.TARGET_ENEMY.NAME)	

	
	this.SetUpHostage(this.HOSTAGELIST)
end


this.OnLoad = function ()
	Fox.Log("*** s10115 onload ***")
	mtbs_enemy.useUiSetting = false					

	
	
	
	local clusterId = 2 + 1
	Fox.Log("*** s10115enemy.OnLoad ::ClusterID = ***"..clusterId)
	mtbs_enemy.OnLoad( clusterId, true )

	
	this.soldierDefine = mtbs_enemy.soldierDefine
	this.soldierSubTypes = mtbs_enemy.soldierSubTypes
	this.routeSets = mtbs_enemy.routeSets
	this.combatSetting = mtbs_enemy.combatSetting

end

this.OnAllocate = function()
	this.GetRouteSetPriority = mtbs_enemy.GetRouteSetPriority
end










return this
