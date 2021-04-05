local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_Brank_30		 			= "p81_000020_30f",		
	ContactCodetalkerDemo			= "p41_060010",	 		
	CemeteryCodetalkerDemo			= "p41_060020",	 		
	ClearDemo						= "p41_060110",	 		
	ArrivalParasiteDemo				= "p41_060005",	 		
}




this.demoBlockList = {
	_openingDemo		 			= { "/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk"},
	ContactCodetalkerDemo			= { "/Assets/tpp/pack/mission2/story/s10130/s10130_d01.fpk" },
	GetIntelDemo					= { "/Assets/tpp/pack/mission2/story/s10130/s10130_d02.fpk" },
	CemeteryCodetalkerDemo			= { "/Assets/tpp/pack/mission2/story/s10130/s10130_d03.fpk" },
	ArrivalParasiteDemo				= { "/Assets/tpp/pack/mission2/story/s10130/s10130_d04.fpk" },
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10130_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening(
		{ onEnd = function() func() end,},
		{ useDemoBlock = true }
	)
end



this.GetIntel_inMansion = function(func)
	Fox.Log("#### s10130_demo.PlayGetIntelDemo ####")
	TppDemo.PlayGetIntelDemo(
		{
			onEnd = function() func() end,
		},
		"GetIntelIdentifier","GetIntel_inMansion"
	)
end



this.Demo_Brank_30 = function( func_init , func_start , func_end )
	TppDemo.Play("Demo_Brank_30",{
		onInit	= function() func_init() end,
		onEnd	= function() func_end() end,
	}, { interpGameToDemo = false , useDemoBlock = true, isSnakeOnly = false, } )
end



this.PlayContactCodetalkerDemo = function(func)
	Fox.Log("#### s10130_demo.PlayContactCodetalkerDemo ####")
	
	if svars.isAllKillParasite == false then
		TppDemo.Play(
			"ContactCodetalkerDemo", { onEnd = func },		
			{ useDemoBlock = true, }
		)
	else
		TppDemo.Play(
			"ContactCodetalkerDemo", { onEnd = func },		
			{ 
				useDemoBlock = true,
				finishFadeOut = true,	
			}
		)
	end
end




this.PlayCemeteryCodetalkerDemo = function(func)
	Fox.Log("#### s10130_demo.PlayCemeteryCodetalkerDemo ####")
	TppDemo.SpecifyIgnoreNpcDisable( "CodeTalker" )
	TppDemo.Play(
		"CemeteryCodetalkerDemo", { onEnd = func },		
		{ useDemoBlock = true, isSnakeOnly = false, }
	)
end




this.ArrivalParasiteDemo = function(func)

	local funcOnInit = function()
		Fox.Log("#### s10130_demo.PlayArrivalParasiteDemo.1fBefore ####")
		
		s10130_enemy.CamoParasiteOn()
		s10130_enemy.CombatCamoParasiteSeq01BeforeDemo()
	end

	Fox.Log("#### s10130_demo.PlayArrivalParasiteDemo ####")
	TppDemo.Play(
		"ArrivalParasiteDemo",
		{
			onInit = funcOnInit,
			onEnd = func,
		},		
		{ useDemoBlock = true, isSnakeOnly = false, }
	)
end




this.PlayClearDemo = function(func)
	Fox.Log("#### s10130_demo.PlayClearDemo ####")
	TppDemo.Play(
		"ClearDemo", { onEnd = func },		
		{
			waitBlockLoadEndOnDemoSkip = false,
			startNoFadeIn		= true,
			isExecMissionClear = true,
			finishFadeOut = true,	
		}
	)
end




return this
