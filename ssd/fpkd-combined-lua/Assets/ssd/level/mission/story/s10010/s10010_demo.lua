local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	readyFuneral = "p10_000010",
	battleOnMb = "p10_000020",
	burial = "p10_000030",
	souvenirPhotograph = "p10_000035",
	wormhole = "p10_000040",
	arriveInAfgh = "p10_000050",
	encountReeve = "p10_000056",
	reunionReeve = "p10_000057",
	zombieAppearance = "p10_000055",
	relics = "p10_000060",
	retrospect = "p10_000070",
	recapture = "p10_000080",
	encounterAi = "p20_000010",
}




this.demoBlockList = {
	readyFuneral = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	battleOnMb = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	burial = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	souvenirPhotograph = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	wormhole = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	arriveInAfgh = { "/Assets/ssd/pack/mission/story/s10010/s10010_d02.fpk", },
	encountReeve = { "/Assets/ssd/pack/mission/story/s10010/s10010_d02.fpk", },
	reunionReeve = { "/Assets/ssd/pack/mission/story/s10010/s10010_d02.fpk", },
	zombieAppearance = { "/Assets/ssd/pack/mission/story/s10010/s10010_d03.fpk", },
	relics = { "/Assets/ssd/pack/mission/story/s10010/s10010_d03.fpk", },
	retrospect = { "/Assets/ssd/pack/mission/story/s10010/s10010_d01.fpk", },
	recapture = { "/Assets/ssd/pack/mission/story/s10010/s10010_d04.fpk", },
	encounterAi = { "/Assets/ssd/pack/mission/story/s10010/s10010_d04.fpk", },
}




this.PlayReadyFuneral = function( funcs )
	Fox.Log( "s10010_demo.PlayReadyFuneral()" )
	TppDemo.Play( "readyFuneral", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayBattleOnMb = function( funcs )
	Fox.Log( "s10010_demo.PlayBattleOnMb()" )
	TppDemo.Play( "battleOnMb", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayBurial = function( funcs )
	Fox.Log( "s10010_demo.PlayBurial()" )
	TppDemo.Play( "burial", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlaySouvenirPhotograph = function( funcs )
	Fox.Log( "s10010_demo.PlaySouvenirPhotograph()" )
	TppDemo.Play( "souvenirPhotograph", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayWormhole = function( funcs )
	Fox.Log( "s10010_demo.PlayWormhole()" )
	TppDemo.Play( "wormhole", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayArriveInAfgh = function( funcs )
	Fox.Log( "s10010_demo.PlayArriveInAfgh()" )
	TppDemo.Play( "arriveInAfgh", funcs, { startNoFadeIn = true, isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false, useDemoBlock = true, } )
end

this.PlayZombieAppearance = function( funcs )
	Fox.Log( "s10010_demo.PlayZombieAppearance()" )
	TppDemo.Play( "zombieAppearance", funcs, { isSnakeOnly = false, ignorePlayerAction = true, waitBlockLoadEndOnDemoSkip = false, useDemoBlock = true, } )
end

this.PlayEncountReeve = function( funcs )
	Fox.Log( "s10010_demo.PlayEncountReeve()" )
	TppDemo.Play( "encountReeve", funcs, { isSnakeOnly = false, ignorePlayerAction = true, waitBlockLoadEndOnDemoSkip = false, useDemoBlock = true, } )
end

this.PlayReunionReeve = function( funcs )
	Fox.Log( "s10010_demo.PlayReunionReeve()" )
	TppDemo.Play( "reunionReeve", funcs, { isSnakeOnly = false, ignorePlayerAction = true, waitBlockLoadEndOnDemoSkip = false, finishFadeOut = true, useDemoBlock = true, } )
end

this.PlayRelics = function( funcs )
	Fox.Log( "s10010_demo.PlayRelics()" )
	TppDemo.Play( "relics", funcs, { finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayRetrospect = function( funcs )
	Fox.Log( "s10010_demo.PlayRetrospect()" )
	TppDemo.Play( "retrospect", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, useDemoBlock = true, } )
end

this.PlayRecapture = function( funcs )
	Fox.Log( "s10010_demo.PlayRecapture()" )
	TppDemo.Play( "recapture", funcs, { startNoFadeIn = true, finishFadeOut = true, isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false, useDemoBlock = true, } )
end

this.PlayEncounterAi = function( funcs )
	Fox.Log( "s10010_demo.PlayEncounterAi()" )
	TppDemo.Play( "encounterAi", funcs, { startNoFadeIn = false, finishFadeOut = true, isExecMissionClear = true, isSnakeOnly = false, useDemoBlock = true, } )
end




return this
