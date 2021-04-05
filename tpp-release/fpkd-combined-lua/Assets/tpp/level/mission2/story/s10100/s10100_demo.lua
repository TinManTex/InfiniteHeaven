local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.demoList = {
	Demo_Brank_30		 	= "p81_000020_30f",				
	Demo_MeetBoySoldier 	= "p41_020020_000",				
}



this.demoBlockList = {
	Demo_MeetBoySoldier		= { "/Assets/tpp/pack/mission2/story/s10100/s10100_d01.fpk" },
}





this.Demo_Brank_30 = function( func_init , func_start , func_end )
	Fox.Log("----------------------------- 30 -------------------------------------")
	TppDemo.Play("Demo_Brank_30",{
		onInit	= function() func_init() end,
		onEnd	= function() func_end() end,
	}, { interpGameToDemo = false , useDemoBlock = true, isSnakeOnly = false,} )
end

this.Demo_MeetBoySoldier = function( func_init , func_start , func_end )
	TppDemo.Play("Demo_MeetBoySoldier",{
		onInit	= function() func_init() end,
		onEnd = function() func_end() end,
	}, { useDemoBlock = true, } )
end



return this
