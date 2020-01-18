local this = {}
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}

local TIME_CHECK_FOCUS_AREA = 3*60	

local TIMER_NAME_CHECK_FOCUS_AREA = "CheckFocusArea"
local TIMER_NAME_PERMIT_SEARCHING_DEFENDER = "PermitSearchingDefender"

local NUM_MEMBER_MIN = 2
local NUM_MEMBER_MAX = 4

local GDTGT_MEMBER_LIST = {
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
	{	
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
		{ min = NUM_MEMBER_MIN, MAX = NUM_MEMBER_MAX },
	},
}





this.soldierDefine = {}




this.soldierSubTypes = {}


this.routeSets = {}


this.GetRouteSetPriority = nil


this.combatSetting = {}


this.interrogation = {
	
}






 
this.SetMarkerOnDefence = function()
	Fox.Log("*** SetMarkerOnDefence *** ")

	
	Fox.Log("######## SetMarkerOnSoldier ########")
	for _, plntName in ipairs( mtbs_enemy.plntNameDefine ) do
		
		for idx = 1, table.getn(this.soldierDefine[mtbs_enemy.cpNameDefine]) do

			TppMarker2System.EnableMarker{
				gameObjectId = GameObject.GetGameObjectId( this.soldierDefine[mtbs_enemy.cpNameDefine][idx] ),
			}
		end
	end
end


 
this.SetFriendly = function()
	Fox.Log("*** SetFriendly *** ")
	local GetGameObjectId = GameObject.GetGameObjectId
	local SendCommand = GameObject.SendCommand
	local command = { id="SetFriendly" }

	
	SendCommand( { type="TppSoldier2"}, command )

	
	for _, plntName in ipairs( mtbs_enemy.plntNameDefine ) do
		
		local plntTable = mtbs_enemy.plntParamTable[plntName]
		local plntAssetsTable = plntTable.assets
		
		for i, uavName in ipairs( plntAssetsTable.uavList ) do
			local gameObjectId = GameObject.GetGameObjectId( uavName )
			SendCommand( gameObjectId, {id = "SetFriendly"} )
		end
	end

	
	SendCommand( { type="TppSecurityCamera2"}, command )
end

 
this.SetSaluteMoraleDisableAll = function()
	Fox.Log("*** SetSaluteMoraleDisable *** ")
	local GetGameObjectId = GameObject.GetGameObjectId
	local SendCommand = GameObject.SendCommand
	local command = { id="SetSaluteMoraleDisable", enabled=true }
	for idx = 1, table.getn(this.soldierDefine[mtbs_enemy.cpNameDefine]) do
		local gameObjectId = GetGameObjectId("TppSoldier2", this.soldierDefine[mtbs_enemy.cpNameDefine][idx])
		if gameObjectId ~= NULL_ID then
			SendCommand( gameObjectId, command )
		end
	end
end


this.SetTimerCheckFocusArea = function()
	GkEventTimerManager.StartRaw(TIMER_NAME_CHECK_FOCUS_AREA, TIME_CHECK_FOCUS_AREA )
end

this.SetupPracticeMode = function()
	
	local gameObjectId = { type="TppSoldier2" }
	local command = { id = "SetNoBloodMode", enabled=true }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetEnemyRespawnTime = function()
	Fox.Log("*** o50050_enemy SetRespawnTime *** ")
	local cpId = { type="TppCommandPost2" } 

	
	local time = 90.0

	local respawnTimeCountList = {}
	
	respawnTimeCountList = {
		90,		
		85,		
		75,		
		65,		
		55,
		45,
		30,
		10,		
	}

	
	local sectionRankForDefence = TppMotherBaseManagement.GetMbsCombatSectionRank{ type = "Defence" } + 1

	
	if respawnTimeCountList[sectionRankForDefence] ~= nil then
		time = respawnTimeCountList[sectionRankForDefence]
	else
		Fox.Error("### SetRespawnTime :: Set time is nil ###")
	end

	local command = { id = "SetReinforceTime", time=time }
	GameObject.SendCommand( cpId, command )
end

this.SetGuardTagetMember = function( clstId )
	Fox.Log("*** SetGuardTagetMember *** clstId = " .. clstId)
	local gdList = {
		mtbs_enemy.plnt0_gtNameDefine,
		mtbs_enemy.plnt1_gtNameDefine,
		mtbs_enemy.plnt2_gtNameDefine,
		mtbs_enemy.plnt3_gtNameDefine,
	}
	local cpId = { type="TppCommandPost2" } 

	for key, value in ipairs(gdList) do
		local count = math.random(GDTGT_MEMBER_LIST[clstId][key].min, GDTGT_MEMBER_LIST[clstId][key].MAX)
		local front = count
		Fox.Log("*** SetGuardTagetMember *** key = " .. key .. "value = " .. value .. "count = ".. count)
		local command = { id = "SetLocatorMemberCount", name = value, count = count, front = front, }
		GameObject.SendCommand( cpId, command )
	end
end



 
this.SearchingDefencePlayer = function()
	Fox.Log("### SearchingDefencePlayer ###")
	
	
	if o50050_sequence.IsThereDefencePlayer() == true then
		
		TppUiCommand.ExecSpySearchForFobSneak{ visibleSec = mvars.numSearchingDefenceTime }

		
		TppUI.ShowAnnounceLog( "updateMap" )
		
		
		
		GkEventTimerManager.StartRaw(TIMER_NAME_PERMIT_SEARCHING_DEFENDER, mvars.numSearchingDefenceTime )
	end
end

 
this.INTER_SEARCHING_DEFENCE = { name = "enqt1000_101521", func = this.SearchingDefencePlayer, }






this.InitEnemy = function ()
	Fox.Log("*** o50050 InitEnemy ***")
	local clusterId = MotherBaseStage.GetFirstCluster() + 1
	if not clusterId then
		Fox.Error("clusterId is nil")
	end
	mtbs_enemy.InitEnemy(clusterId)

	
	this.interrogation = {
		
		[mtbs_enemy.cpNameDefine] = {
			high = {
				this.INTER_SEARCHING_DEFENCE,		
				nil
			},
			nil
		},
		nil
	}
end



this.SetUpEnemy = function ()
	Fox.Log("*** o50050 SetUpEnemy ***")
	local clusterId = MotherBaseStage.GetFirstCluster() + 1
	local sortieSoldierNum = mtbs_enemy.SetupEnemy( clusterId )

	
	mvars.mbSoldier_placedCountTotal = 0
	if mvars.mbSoldier_enableSoldierLocatorList[clusterId] ~= nil then
		mvars.mbSoldier_placedCountTotal = #mvars.mbSoldier_enableSoldierLocatorList[clusterId]
	end

	if sortieSoldierNum == nil then
		Fox.Error("*** sortieSoldier = nil ***")
	 	return
	end
	this._SetupReinforce( clusterId, sortieSoldierNum )

	
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

	this.SetGuardTagetMember( clusterId )

	
	if vars.fobSneakMode == FobMode.MODE_SHAM then
		this.SetupPracticeMode()
	end
	
	
	if vars.fobSneakMode == FobMode.MODE_VISIT then
		this.SetFriendly()
		
		if TppMotherBaseManagement.IsMbsOwner{} ~= true then
			Fox.Log("### Not Owner ###")
			this.SetSaluteMoraleDisableAll()
		end
	end
	
	
	this.SetEnemyRespawnTime()
end


this.OnLoad = function ()
	Fox.Log("*** o50050 onload ***")
	local clusterId = MotherBaseStage.GetFirstCluster() + 1
	local securityStaffIdList, rewardStaffIds = TppMotherBaseManagement.GetStaffsFob()
	mvars.o50050_rewardStaffIds = rewardStaffIds
	mtbs_enemy.SetSecurityStaffIdList( clusterId, securityStaffIdList )
	mtbs_enemy.OnLoad( clusterId )

	
	this.soldierDefine = mtbs_enemy.soldierDefine
	this.soldierSubTypes = mtbs_enemy.soldierSubTypes
	this.routeSets = mtbs_enemy.routeSets
	this.combatSetting = mtbs_enemy.combatSetting

end


this.OnAllocate = function()
	this.GetRouteSetPriority = mtbs_enemy.GetRouteSetPriority

	














end

function this.Messages()
	return
	StrCode32Table {
		Timer = {
			{
				msg = "Finish",
				sender = TIMER_NAME_CHECK_FOCUS_AREA,
				func = function()
					GkEventTimerManager.Stop(TIMER_NAME_CHECK_FOCUS_AREA)
					local clusterId = mtbs_cluster.GetCurrentClusterId()
					mtbs_enemy.StartCheckFocusArea( clusterId )
					this.SetTimerCheckFocusArea()
				end,
			},
			{
				msg = "Finish",
				sender = TIMER_NAME_PERMIT_SEARCHING_DEFENDER,
				func = function()
					GkEventTimerManager.Stop(TIMER_NAME_PERMIT_SEARCHING_DEFENDER)
					local cp = GameObject.GetGameObjectId(mtbs_enemy.cpNameDefine)
					TppInterrogation.MakeFlagHigh( cp )
				end,
			},
		},
		nil
	}
end

function this._SetupReinforce( clusterId, sortieSoldierNum )
	mvars.o50050_usedStaffNum = sortieSoldierNum 
	local canSortieStaffList = mtbs_enemy.GetSecurityStaffIdList(clusterId)
	local reinforceCount = #canSortieStaffList - sortieSoldierNum
	local maxReinforceCountFromSecurityRank = this._GetMaxRespawnSoldierNum()
	if reinforceCount > maxReinforceCountFromSecurityRank then
		reinforceCount = maxReinforceCountFromSecurityRank
	end
	Fox.Log("SetupReinforceNum:" ..tostring(reinforceCount) )
	local cpId = { type="TppCommandPost2" } 
	local command = { id = "SetFOBReinforceCount", count=reinforceCount }
	GameObject.SendCommand( cpId, command )
end


function this.AssignAndSetupRespawnSoldier(gameObjectId)
	
	local serverStaffIdList = mtbs_enemy.GetSecurityStaffIdList(mtbs_cluster.GetCurrentClusterId())
	local serverStaffId = 			serverStaffIdList[mvars.o50050_usedStaffNum+1]
	mvars.o50050_usedStaffNum =						  mvars.o50050_usedStaffNum+1	

	
	mtbs_enemy.SetStaffId( gameObjectId , serverStaffId )
	if not serverStaffId then
		Fox.Error("no staffId. but, respawnSoldier")
		return	
	end
	
	mtbs_enemy.SetStaffAbirity( serverStaffId, gameObjectId )
	
	local faceId = TppMotherBaseManagement.StaffIdToFaceId{ staffId=serverStaffId }
	TppEneFova.ApplyMTBSUniqueSetting( gameObjectId, faceId, true )
end

function this._GetMaxRespawnSoldierNum()
	local rank = TppMotherBaseManagement.GetMbsCombatSectionRank{ type = "Defence" }
	local RESPORN_MAX = {
		4,	
		4,	
		8,	
		16, 
		32, 
		48, 
		100 
	}
	local maxRespornNum = RESPORN_MAX[rank]
	Fox.Log("GetMaxRespawnSoldierNumForRank:" ..tostring(maxRespornNum) )
	if maxRespornNum then
		return maxRespornNum
	else
		return 0
	end
end




return this
