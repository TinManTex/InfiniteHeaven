local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	test = test
}





this.PlayOpeningDemo = function(func)
	Fox.Log( "c20210_demo.PlayOpeningDemo()" )
	TppDemo.PlayOpening{ onEnd 	= function() func() end,	} 
end





return this
