local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_GetIntel	= "p31_010025",	
}




this.demoBlockList = {

	Demo_GetIntel 	= { "/Assets/tpp/pack/mission2/story/s10211/s10211_d01.fpk"},
}














this.GetIntel_savannah = function(func)
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function() func() end,
			useDemoBlock = true,
		},
		"GetIntelIdentifier","GetIntel_savannah"
	)
end




return this
