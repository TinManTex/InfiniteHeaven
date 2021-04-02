local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_GetIntel = "p31_010025_001",
}

this.demoBlockList = {
	_openingDemo 				= { "/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk"},
	Demo_GetIntel		 		= { "/Assets/tpp/pack/mission2/story/s10044/s10044_d01.fpk" },
}




this.PlayOpeningDemo = function(func)
	Fox.Log("opening demo 10044")
	TppDemo.PlayOpening(
		{ 
			onEnd = function() func() end,
		},
		{ 
			useDemoBlock = true 
		}
	)
end


this.PlayGetIntel = function(func)
	Fox.Log("opening PlayGetIntelDemo PlayGetIntelDemo PlayGetIntelDemo")
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function() func() end,
		},
			"GetIntelIdentifier",
			"GetIntel_showConvoy",
		{
			useDemoBlock = true
		}
	)
end





return this