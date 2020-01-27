




local this = BaseFlagMission.CreateInstance( "k40320" )

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local NULL_ID = GameObject.NULL_ID
local GetGameObjectId = GameObject.GetGameObjectId
local SendCommand = GameObject.SendCommand
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeNumber = Tpp.IsTypeNumber

this.registerRescueTargetUniqueCrew = {
	locatorName = "npc_k40320_0000",
	uniqueType = CrewType.UNIQUE_CHARON,
}

local lastAddedStep


this.missionAreas = {
	{ 
		name = "marker_missionArea_0000", 
		trapName = "trap_missionArea_0000", 
		visibleArea = 4, 
		guideLinesId = "guidelines_mission_common_signal",
	},
	{ 
		name = "marker_missionArea_0001", 
		trapName = "trap_missionArea_0001", 
		visibleArea = 4, 
		hide = true 
	},
}


this.disableEnemy = {
	{ enemyName = "zmb_lab_02_0000",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0001",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0002",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0003",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0004",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0005",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0006",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0007",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_02_0008",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_bom_lab_03_0001",	enemyType = "SsdZombieBom", },
	{ enemyName = "zmb_bom_lab_03_0002",	enemyType = "SsdZombieBom", },
	{ enemyName = "zmb_lab_03_0000",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_03_0001",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_03_0002",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_03_0003",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_lab_03_0004",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0000",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0001",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0002",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0003",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0004",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0005",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_116_0006",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0000",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0001",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0002",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0003",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0004",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0005",		enemyType = "SsdZombie", },
	{ enemyName = "zmb_153_117_0006",		enemyType = "SsdZombie", },
	{ enemyName = "Mimic_lab_01_0015",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0016",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0017",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0018",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0019",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0021",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0022",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0023",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0032",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0033",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0034",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0001",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0002",		enemyType = "SsdInsect3", },
	{ enemyName = "Mimic_lab_01_0005",		enemyType = "SsdInsect3", },
































}


this.enemyRouteTable = {
	
	{ enemyName = "zmr_k40320_r_0000",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0000", },
	{ enemyName = "zmr_k40320_r_0001",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0001", },
	{ enemyName = "zmr_k40320_r_0002",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0002", },
	{ enemyName = "zmr_k40320_r_0003",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0003", },
	{ enemyName = "zmr_k40320_r_0004",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0004", },
	{ enemyName = "zmr_k40320_r_0005",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0005", },
	{ enemyName = "zmr_k40320_r_0006",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0006", },
	{ enemyName = "zmr_k40320_r_0007",	enemyType = "SsdZombieArmor",	routeName = "rt_zmr_k40320_r_0007", },
	
	{ enemyName = "zmd_k40320_r_0000",	enemyType = "SsdZombieDash",	routeName = "rt_zmd_k40320_r_0000", },
	{ enemyName = "zmd_k40320_r_0001",	enemyType = "SsdZombieDash",	routeName = "rt_zmd_k40320_r_0001", },
	
	{ enemyName = "zml_k40320_r_0000",	enemyType = "SsdZombieShell",	routeName = "rt_zml_k40320_r_0000", },
	{ enemyName = "zml_k40320_r_0001",	enemyType = "SsdZombieShell",	routeName = "rt_zml_k40320_r_0001", },
	
	{ enemyName = "zmf_k40320_r_0000",	enemyType = "SsdZombie",		routeName = "rt_zmf_k40320_r_0000", },
}






this.ZombieAttributeTableList = {
	{ enemyName = "zmf_k40320_0000",	type = "Fire", },
	{ enemyName = "zmf_k40320_0001",	type = "Fire", },
	{ enemyName = "zmf_k40320_0002",	type = "Fire", },
	{ enemyName = "zmf_k40320_0003",	type = "Fire", },
	{ enemyName = "zmf_k40320_0004",	type = "Fire", },
	{ enemyName = "zmf_k40320_0005",	type = "Fire", },
	{ enemyName = "zmf_k40320_0006",	type = "Fire", },
	{ enemyName = "zmf_k40320_r_0000",	type = "Fire", },
}


this.BridgeGimmickTableList = {
	{	
		type		= TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
		locatorName	= "mafr_brdg007_vrtn001_gim_n0001|srt_mafr_brdg007_vrtn001_0001",
		dataSetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_asset.fox2",
		fvarsName	= "isBreakGimmickBridge01",
	},
	{	
		type		= TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
		locatorName	= "mafr_brdg007_vrtn001_gim_n0002|srt_mafr_brdg007_vrtn001_0001",
		dataSetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_asset.fox2",
		fvarsName	= "isBreakGimmickBridge02",
	},
	{	
		type		= TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
		locatorName	= "mafr_brdg007_vrtn001_gim_n0003|srt_mafr_brdg007_vrtn001_0001",
		dataSetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_asset.fox2",
		fvarsName	= "isBreakGimmickBridge03",
	},
	{	
		type		= TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
		locatorName	= "mafr_brdg007_vrtn001_gim_n0004|srt_mafr_brdg007_vrtn001_0001",
		dataSetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_asset.fox2",
		fvarsName	= "isBreakGimmickBridge04",
	},
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isBreakGimmickBridge01",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isBreakGimmickBridge02",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isBreakGimmickBridge03",			type = TppScriptVars.TYPE_BOOL, value = true,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isBreakGimmickBridge04",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioMissionArea",				type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisableMissionArea( "marker_missionArea_0000" )
		this.DisplayMissionArea( "marker_missionArea_0001" )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
	
	
	this.SetZombieAttribute()

end




this.SetZombieAttribute = function()
	if IsTypeTable( this.ZombieAttributeTableList ) then
		for _, data in ipairs( this.ZombieAttributeTableList ) do
			if data.enemyName and data.type then
				local gameObjectId = { type="SsdZombie" }
				local command = { id="SetZombieEXType", type = data.type, locatorName = data.enemyName }
				GameObject.SendCommand( gameObjectId, command )
			end
		end
	end
end




this.SetTrapBreakGimmick = function()
	if IsTypeTable( this.BridgeGimmickTableList ) then
		for _, data in ipairs( this.BridgeGimmickTableList ) do
			local isBreakGimmick = true
			if fvars[data.fvarsName] == false then
				isBreakGimmick = false
			end
			if isBreakGimmick == true then
				Gimmick.BreakGimmick(
					data.type,
					data.locatorName,
					data.dataSetName
				)
			end
		end
	end
end




this.OnBreakGimmick = function( gameObjectId )
	if gameObjectId == nil then
		return
	end
	if IsTypeTable( this.BridgeGimmickTableList ) then
		for _, data in ipairs( this.BridgeGimmickTableList ) do
			if fvars[data.fvarsName] == false then
				local ret, gimmickGameObjectId = Gimmick.GetGameObjectId( data.type, data.locatorName, data.dataSetName )
				if gameObjectId == gimmickGameObjectId then
					fvars[data.fvarsName] = true
				end
			end
		end
	end
end




this.messageTable = {
	Trap = {
		{	
			sender = "trap_breakGimmickBridge",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				Fox.Log( "k40320.Messages(): Trap: msg:Enter, trap_breakGimmickBridge" )
				
				this.SetTrapBreakGimmick()
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea_0000",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				Fox.Log( "k40320.Messages(): Trap: msg:Enter, trap_missionArea_0000" )
				if fvars.isRadioMissionArea == false then
					TppRadio.Play( "f3010_rtrg2704", { delayTime = "mid" } )
					fvars.isRadioMissionArea = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
	GameObject = {
		{
			msg = "BreakGimmick",
			func = function( gameObjectId, locatorName, upperLocatorName, on )
				Fox.Log( "k40320.Messages(): GameObject: msg:BreakGimmick, gameObjectId:" .. tostring( gameObjectId ) )
				this.OnBreakGimmick( gameObjectId )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameMain",
	OnEnter = function()
		
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end,
	options = {
		marker = {
			{ name = "marker_target_0000", areaName = "marker_missionArea_0000", },
		},
		radio = "f3010_rtrg2708",
		objective = "mission_40020_objective_02",
		checkObjectiveIfCleared = "mission_40020_objective_02",
		onLeaveRadio = { "f3010_rtrg2706" },
	},
	clearConditionTable = {
		carry = {
			{ locatorName = "npc_k40320_0000", },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea_0000" )
		
		this.DisplayMissionArea("marker_missionArea_0001")
	end,
	options = {
		continueRadio = "f3010_rtrg2708",
		objective = "mission_40180_objective_02",
		checkObjectiveIfCleared = "mission_40180_objective_02",
		marker = {
			{ name = "marker_target_0001", areaName = "marker_missionArea_0001", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
	},
	clearConditionTable = {
		rescue = {
			{
				locatorName = "npc_k40320_0000",
				rescueDemo = { demoName = "p01_000020", options = { finishFadeOut = true } },
				checkObjective = "mission_40020_objective_03",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisableMissionArea( "marker_missionArea_0001" )
	end,
	options = {
	},
	clearConditionTable = {
		clearStage = true,
	},
}




this.resultRadio = "f3010_rtrg2710"

return this
