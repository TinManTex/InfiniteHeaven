local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	BeforeSethBattle = "p50_000005",	
	AfterSethBattle = "p50_000007",		
}




this.PlayBeforeSethBattle = function( funcs )
	Fox.Log( "s10050_demo.PlayBeforeSethBattle()" )
	TppDemo.Play( "BeforeSethBattle", funcs, { finishFadeOut = false, isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false, } )
end

this.PlayAfterSethBattle = function( funcs )
	Fox.Log( "s10050_demo.PlayAfterSethBattle()" )
	TppDemo.Play( "AfterSethBattle", funcs, { finishFadeOut = false, isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false, isExecMissionClear = true } )
end




return this
