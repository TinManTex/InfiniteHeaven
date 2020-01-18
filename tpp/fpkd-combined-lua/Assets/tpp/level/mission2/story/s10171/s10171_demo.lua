local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoBlockList = {
	_openingDemo    = {"/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk"},
	Demo_GetIntel = { "/Assets/tpp/pack/mission2/story/s10171/s10171_d01.fpk" },
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10171_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening( { onEnd = function() func() end,}, { useDemoBlock = true, } )
end





this.PlayGetIntel_showRoute = function( func )
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function()
				
				TppMission.UpdateObjective{
					objectives = { "Area_marker_target"  },
				}
				s10171_radio.PlayGetIntelRadio()
				
				TppMission.UpdateCheckPoint(
					{ checkPoint = "CHK_GetIntel", atCurrentPosition = true }
				)
			end,
			useDemoBlock = true,
		},
		"GetIntelIdentifier","GetIntel_showRoute"
	)
end



return this
