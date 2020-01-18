local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_GetIntel	= "p31_010025",	
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10033_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening{ onEnd 	= function() func() end,	} 
end

this.GetIntel_enemyBase = function(func)
	Fox.Log("#### s10033_demo.GetIntel_enemyBase ####")
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function()
				func()
			end,
		},
		"GetIntelIdentifier",
		"intel_00",
		{
			useDemoBlock = false
		},
		true
	)
end



return this
