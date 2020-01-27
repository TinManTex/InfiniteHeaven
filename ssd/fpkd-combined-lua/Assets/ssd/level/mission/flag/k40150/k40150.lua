




local this = BaseFlagMission.CreateInstance( "k40150" )




this.AddOnTerminate = function()
	Fox.Log("k40150.AddOnTerminate")
	SsdBuilding.UnsetExtensionMission{}
end



this.missionAreas = {
	{ name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 5, },
}




BaseFlagMission.AddStep(
	this,
	"GameMain",
	"GameClear",
	{
		completeCraft = {
			{
				missionObjectiveInfoTable = {
					langId				= "mission_40150_objective_03",
					facilityType = SsdSbm.FACILITY_TYPE_Building,
					productionIdCode = {
						"PRD_BLD_MB_Stair",
					},
				},
			},
			{
				requiredBuilding = "PRD_BLD_MB_Stair",
			},
		},
	},
	{
		radio = "f3010_rtrg1400",
		recipe = {
			"RCP_BLD_MB_Stair",		
		},
	}
)

this.flagStep.GameMain.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	SsdBuilding.SetExtensionMission{level=2}
end




BaseFlagMission.AddStep(
	this,
	"GameClear",
	nil,
	{
		clearStage = {
			demo = {
				demoName = "p01_000030",	
				funcs = {
					SetDemoTransform = function()
						Gimmick.BreakAtTheBaseDefenseEnd() 
						return TppGimmick.AFGH_BASE_AI_POSITION	
					end,
				 },
			},
		}
	}
)




this.resultRadio = "f3010_rtrg1404"




this.blackRadioOnEnd = "K40150_0020"

return this
