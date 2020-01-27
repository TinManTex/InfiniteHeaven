local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	defense = "p30_000010",
	kaiju = "p30_000020",
	mb = "p30_000030",
	explosion = "p30_000040",
	catWalk = "p30_000050",
	wormhole = "p30_000060",
}





this.PlayStartDefense = function( funcs )
	Fox.Log( "s10035_demo.PlayStartDefense()" )
	TppDemo.Play( "defense", funcs, { isSnakeOnly = false, } )
end

this.PlayKaiju = function( funcs )
	Fox.Log( "s10035_demo.PlayKaiju()" )
	TppDemo.Play( "kaiju", funcs, { isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false, finishFadeOut = true, } )
end

this.PlayMB = function( funcs )
	Fox.Log( "s10035_demo.PlayMB()" )
	TppDemo.Play( "mb", funcs, { isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false } )
end

this.PlayExplosion = function( funcs )
	Fox.Log( "s10035_demo.PlayExplosion()" )
	TppDemo.Play( "explosion", funcs, { isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false } )
end

this.PlayCatWalk = function( funcs )
	Fox.Log( "s10035_demo.PlayCatWalk()" )
	TppDemo.Play( "catWalk", funcs, { isSnakeOnly = false, waitBlockLoadEndOnDemoSkip = false  } )
end

this.PlayWormhole = function( funcs )
	Fox.Log( "s10035_demo.PlayWormhole()" )
	TppDemo.Play( "wormhole", funcs, { isSnakeOnly = false, finishFadeOut = true, } )
end




return this
