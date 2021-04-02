local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}



this.demoList = {
	Demo_GetIntel	= "p31_010025",	
}





this.OnLoad = function()
	Fox.Log("#### OnLoad ####")

end

this.OnUpdate = function ()
end








this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10093_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening(
		{
			onEnd = function() func() end,
		}
	)
end


this.GetIntel_inTent = function(func)
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function() func() end,
		},
		"GetIntelIdentifier","GetIntel_inTent"
	)
end

this.GetIntel_inMansion = function(func)
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function() func() end,
		},
		"GetIntelIdentifier","GetIntel_inMansion"
	)
end




return this
