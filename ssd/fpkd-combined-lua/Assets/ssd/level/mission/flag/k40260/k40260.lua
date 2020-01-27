




local this = BaseFlagMission.CreateInstance( "k40260" )


this.missionAreas = {
	{ name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 3, guideLinesId = "guidelines_mission_40260_01", },
}




this.AddOnTerminate = function()
	Fox.Log("k40260.AddOnTerminate")
	SsdBuilding.UnsetExtensionMission{}
end

local lastAddedStep




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	OnEnter = function()
		SsdBuilding.SetExtensionMission{level=3}
		TppGimmick.SetArchaealBladeVisibility( false )
		
		SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_40260_01" } }
	end,
	options = {
		radio = "f3010_rtrg2300",
		recipe = {
			"RCP_BLD_SahelanBlade",	
		},
	},
	clearConditionTable = {
		completeCraft = {
			{
				
				missionObjectiveInfoTable = {
					langId				= "mission_40260_objective_05",		
					facilityType = SsdSbm.FACILITY_TYPE_Building,	
					productionIdCode = {
						"PRD_BLD_SahelanBlade",
					},
				},
			},
			{
				requiredBuilding = "PRD_BLD_SahelanBlade",	
			},
		},
	},
}




BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = {
				demoName = "p01_000030",	
				funcs = {
					onInit = function()
						TppGimmick.SetArchaealBladeVisibility( true )
					end,
					SetDemoTransform = function()
						return Vector3( -363.70730000, 287.32600000, 2194.63400000 )	
					end,
				 },
			}
		}
	},
}




this.clearRadio = "f3000_rtrg0213"




this.blackRadioOnEnd = "K40260_0020"


return this
