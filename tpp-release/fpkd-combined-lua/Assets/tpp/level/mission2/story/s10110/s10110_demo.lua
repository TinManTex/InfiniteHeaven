local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_GetIntel	= "p31_010025",	
	bedDemoName = "p41_040130_000_final", 
	volginDemoNameBefore = "p41_040145", 
	volginDemoName = "p41_040150_000_final", 
}




this.demoBlockList = {
	_openingDemo = { "/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk" },
	Demo_GetIntel = { "/Assets/tpp/pack/mission2/story/s10110/s10110_d01.fpk" },
	bedDemoName = { "/Assets/tpp/pack/mission2/story/s10110/s10110_d04.fpk" },
	volginDemoNameBefore = { "/Assets/tpp/pack/mission2/story/s10110/s10110_d02.fpk" },
	volginDemoName = { "/Assets/tpp/pack/mission2/story/s10110/s10110_d02.fpk" },
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10110_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening( { onEnd = function() func() end,}, { useDemoBlock = true, } )
end





this.PlayGetIntel_factorySouth = function( func )
	TppDemo.PlayGetIntelDemo( 
		{
			onEnd = function()
				
				
				TppMission.UpdateObjective{
					radio = { radioGroups = { "s0110_rtrg0020" } }, 
					objectives = { "ClearTask_GetIntel" },
				}
			end,
			useDemoBlock = true,
		},
		"GetIntelIdentifier","GetIntel_factorySouth"
	)
end





this.PlayBedDemo = function( func )

	Fox.Log("#### s10110_demo.PlayBedDemo ####")
	TppDemo.Play( "bedDemoName", {
		onStart = function()
			
			
		end,
		onEnd = function()
			TppSequence.SetNextSequence( "Seq_Game_SearchTarget" )
			
			TppScriptBlock.LoadDemoBlock("volginDemoName")
			
			local gameObjectId = GameObject.GetGameObjectId( "TppHostage2GameObjectLocator0000" )
			local command = { id="SetHostage2Flag", flag="event", on=true }
			GameObject.SendCommand( gameObjectId, command )
		end,
	}, { useDemoBlock = true, } )

end





this.PlayVolginDemoBefore = function( func )
	Fox.Log("#### s10110_demo.PlayVolginDemoBefore ####")
	TppDemo.Play( "volginDemoNameBefore", {
		onEnd = function()
			
			Fox.Log("#### s10110_demo.PlayVolginDemoBefore_End ####")
			TppMission.Reload{
				isNoFade = false,													
				showLoadingTips = false, 
				missionPackLabelName = "AfterVolginDemo",					
				OnEndFadeOut = function()											
					TppSequence.ReserveNextSequence( "Seq_Demo_Volgin" )
					TppMission.UpdateCheckPointAtCurrentPosition()
				end,
			}
		end,
	}, { useDemoBlock = true, startNoFadeIn = true, isSnakeOnly = false, } )
end





this.PlayVolginDemo = function( func )
	Fox.Log("#### s10110_demo.PlayVolginDemo ####")
	TppDemo.Play( "volginDemoName", {
		onEnd = function()
			TppSequence.SetNextSequence( "Seq_Game_Escape" )
		end,
	}, { useDemoBlock = true, } )
end


















return this
