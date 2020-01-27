




local this = BaseFlagMission.CreateInstance( "k40270" )

local baseImportantGimmickList = TppGimmick.GetBaseImportantGimmickList() or {}

baseImportantGimmickList[4].checkObjective = "mission_common_objective_bootDigger"
baseImportantGimmickList[4].isPowerOn = true


this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_MissionArea",
		visibleArea = 3,
		guideLinesId = "guidelines_mission_common_wormhole",
	},
}




this.AddOnTerminate = function()
	Fox.Log("k40270.AddOnTerminate")
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
end

local lastAddedStep




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	OnEnter = function()
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	options = {
		radio = "f3010_rtrg2400",
		marker = { name = "marker_diggerSwitch", areaName = "marker_missionArea", viewType = "world_only_icon", mapTextId = "hud_digger_gauge_caption" },
		objective = "mission_common_objective_bootDigger",
	},
	clearConditionTable = {
		switch = {
			baseImportantGimmickList[4],
		},
	},
}




BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = true,
	},
}

return this
