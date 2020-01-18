local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
}



this.demoBlockList = {
	_openingDemo			= {	"/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk"},
}




this.PlayOpeningDemo = function(func)
	Fox.Log("#### PlayOpeningDemo ####")
	TppDemo.PlayOpening( { onEnd = function() func() end,}, { useDemoBlock = true, } )
end



return this
