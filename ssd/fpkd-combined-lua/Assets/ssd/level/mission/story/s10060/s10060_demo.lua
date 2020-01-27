local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	startMission		= "p50_000010",
	selection 			= "p50_000020",
	ai_tell_story1		= "p50_000040",
	ai_tell_story2		= "p50_000041",
	railGunPreparation	= "p50_000042",
	defeatKaiju01		= "p50_000045",
	stay01				= "p50_000050",
	stay02				= "p50_000051",
	Return01			= "p50_000030",
	Return02			= "p50_000031",
}




this.PlayStartMission = function( funcs )
	Fox.Log( "s10060_demo.PlayStartMission()" )
	TppDemo.Play( "startMission", funcs, { isSnakeOnly = false, } )
end

this.PlaySelection = function( funcs )
	Fox.Log( "s10060_demo.PlaySelection()" )
	TppDemo.Play( "selection", funcs, { isSnakeOnly = false, } )
end

this.PlayReturn01 = function( funcs )
	Fox.Log( "s10060_demo.PlayReturn01()" )
	TppDemo.Play( "Return01", funcs, { isSnakeOnly = false, finishFadeOut = true, waitBlockLoadEndOnDemoSkip = false, isExecGameOver = true, } )
end

this.PlayReturn02 = function( funcs )
	Fox.Log( "s10060_demo.PlayReturn02()" )
	TppDemo.Play( "Return02", funcs, { isSnakeOnly = false, finishFadeOut = true, waitTextureLoadOnDemoPlay = true, isExecGameOver = true, } )
end

this.PlayAI_Tell_Story1 = function( funcs )
	Fox.Log( "s10060_demo.PlayAI_Tell_Story1()" )
	TppDemo.Play( "ai_tell_story1", funcs, { isSnakeOnly = false,  finishFadeOut = true, } )
end

this.PlayAI_Tell_Story2 = function( funcs )
	Fox.Log( "s10060_demo.PlayAI_Tell_Story2()" )
	TppDemo.SpecifyIgnoreNpcDisable{ "kij_0000" }	
	TppDemo.Play( "ai_tell_story2", funcs, { isSnakeOnly = false, } )
end

this.PlayRailGunPreparation = function( funcs )
	Fox.Log( "s10060_demo.PlayRailGunPreparation()" )
	TppDemo.Play( "railGunPreparation", funcs, { isSnakeOnly = false, } )
end

this.PlayDefeatKaiju01 = function( funcs )
	Fox.Log( "s10060_demo.PlayDefeatKaiju01()" )
	TppDemo.Play( "defeatKaiju01", funcs, { isSnakeOnly = false, finishFadeOut = true,  waitBlockLoadEndOnDemoSkip = false, isExecMissionClear = true, } )
end

this.PlayStay01 = function( funcs )
	Fox.Log( "s10060_demo.PlayStay01()" )
	TppDemo.Play( "stay01", funcs, { isSnakeOnly = false, finishFadeOut = true,  waitBlockLoadEndOnDemoSkip = false, isExecMissionClear = true, } )
end

this.PlayStay02 = function( funcs )
	Fox.Log( "s10060_demo.PlayStay02()" )
	TppDemo.Play( "stay02", funcs, { isSnakeOnly = false, finishFadeOut = true,  waitBlockLoadEndOnDemoSkip = false, isExecMissionClear = true } )
end




return this
