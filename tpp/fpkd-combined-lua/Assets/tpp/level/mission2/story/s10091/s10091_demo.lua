local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_GetIntel					= "p31_010025",	
}


this.demoBlockList = {
		_openingDemo	= {"/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk"},
		intelDemo	 = {"/Assets/tpp/pack/mission2/story/s10091/s10091_d01.fpk"},
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10091_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening(
		{ onEnd = function() func() end,},
		{ useDemoBlock = true }
	)
end


this.GetIntel_Swamp = function(func)
	TppDemo.PlayGetIntelDemo({ onEnd = function() func() end,},"GetIntelIdentifier","GetIntel_Swamp")
end




return this
