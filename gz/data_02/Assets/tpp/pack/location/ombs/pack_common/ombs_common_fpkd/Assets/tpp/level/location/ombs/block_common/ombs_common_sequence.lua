local this = {}




this.RequiredFiles = {
	"/Assets/tpp/script/common/TppCommon.lua",
}

this.Sequences = {
	{ "Seq_LocationSetup" },
	{ "Seq_MainSequence" },
}

this.OnStart = function( manager )
	TppCommon.Register( this, manager, "location" )
	TppLocation.Setup()
end

this.OnEnterCommon = function()
	local sequence = TppSequence.GetCurrentSequence( "location" )
	Fox.Log( "=== " .. sequence .. " : OnEnter ===" )
end

this.OnLeaveCommon = function()
	local sequence = TppSequence.GetCurrentSequence( "location" )
	Fox.Log( "=== " .. sequence .. " : OnLeave ===" )
end





this.LocationName = "ombs"

this.Times = {
}

this.CommandPostNames = {
}

this.OuterBaseNames = {
}

this.DefaultRouteSets = {
}




this.LocationFlagList = {
}






this.Seq_LocationSetup = {

	OnEnter = function()
		TppSequence.ChangeSequence( "Seq_MainSequence", "location" )
	end,
}


this.Seq_MainSequence = {

	OnEnter = function()
	end,
}




return this