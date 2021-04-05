local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_PrisonBreak_door 				= "p42_010000",	
	Demo_PrisonBreak_window 			= "p42_010010",	
}








this.PrisonBreak = function(func)

	if svars.RoomEntryState == s10081_sequence.SPY_ROOM.DOOR then
		TppDemo.Play("Demo_PrisonBreak_door",{
				onEnd = function() 
					func()
				end,
			},
		{ isSnakeOnly = false, }
		)
	else
		TppDemo.Play("Demo_PrisonBreak_window",{
				onEnd = function() 
					func()
				end,
			},
		{ isSnakeOnly = false, }
		)
	end
end



this.SpyPrisonBreak = function(func)
	TppDemo.Play("Demo_PrisonBreak_window",{ onEnd = function() func() end,} )
end




return this
