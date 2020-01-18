local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	AfterPazResque = "p31_010060",
	ArriveAtDD = "p31_010070",
	OcelotGiveFulton = "p51_010500",
}
if debug then	
this.DEBUG_strCode32List = {
	 "p31_010060",
	 "p31_010070",
	 "p51_010500",

}
end






local DD_SOLDIER_ARRIVED_DEMO_GROUP = {	
	"sol_plant0_0000",
	"sol_plant0_0001",

	"sol_plant0_0003",
	"sol_plant0_0004",
	"sol_plant0_0005",

	"sol_plant0_0007",
	"sol_plant0_0008",
	"sol_plant0_0009",
	"sol_plant0_0010",

}

local DD_SOLDIER_FULTON_DEMO_GROUP = {	
	"sol_plant0_0000",
	"sol_plant0_0001",
	"sol_plant0_0002",
	"sol_plant0_0003",
	"sol_plant0_0004",
	"sol_plant0_0005",
	"sol_plant0_0006",
	"sol_plant0_0007",
	"sol_plant0_0008",
	"sol_plant0_0009",
	"sol_plant0_0010",
	"sol_plant0_0011",
}








this.AfterPazResque = function()

	GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="SetDemoToLandingZoneEnabled ", enabled=true } ) 

	local funcs = {
		onEnd = function()
			TppDemo.ReserveInTheBackGround{ demoName = "ArriveAtDD" }
			TppSequence.SetNextSequence( "Seq_Demo_ArriveAtDD" )

		end,
	}
	Fox.Log("#### s10030_demo.AfterPazResque ####")
	TppDemo.Play( "AfterPazResque", funcs, {  finishFadeOut = true , startNoFadeIn = true,})
end








this.PlayArriveAtDD = function()
	Fox.Log("#### s10030_demo.PlayArriveAtDD ####")
	GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="SetDemoToLandingZoneEnabled ", enabled=true } ) 

	local funcs = {
		onEnd = function()











			
			MotherBaseStage.UnlockCluster()

			TppSequence.SetNextSequence( "Seq_Game_ApproachOcelot" )
		end,

		onSkip = function()
			Fox.Log("#### ON SKIP : s10030_demo.PlayArriveAtDD  ####")

			s10030_enemy.SetRouteAfterDemo()
		end,
	}
	Fox.Log("#### s10030_demo.AfterPazResque ####")

	TppDemo.SpecifyIgnoreNpcDisable( DD_SOLDIER_ARRIVED_DEMO_GROUP )	
	TppDemo.Play( "ArriveAtDD", funcs, {  finishFadeOut = false ,})
end



this.OcelotGiveFulton = function(func)
	Fox.Log("#### s10030_demo.OcelotGiveFulton ####")
	GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="SetDemoToIdleEnabled", enabled=true } ) 
	local funcs = {
		onEnd = function()
		
			mvars.isCarried = false 
			mvars.isSleepTalk= false	
			mvars.isInterruptTalk= false	

			mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.WAITING_2



			
		
		
		end,
	}
	Fox.Log("#### s10030_demo.AfterPazResque ####")
	TppDemo.SpecifyIgnoreNpcDisable( DD_SOLDIER_FULTON_DEMO_GROUP )	
	TppDemo.Play( "OcelotGiveFulton", funcs, {finishFadeOut = false , isSnakeOnly = false , })
end













return this
