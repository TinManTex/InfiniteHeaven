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



end

this.OnLeaveCommon = function()
	local sequence = TppSequence.GetCurrentSequence( "location" )



end





this.LocationName = "gntn"

this.Times = {
	day		= "5:00:00",
	night	= "19:00:00",
}

this.CommandPostNames = {
}

this.OuterBaseNames = {
}

this.DefaultRouteSets = {
	
	
	{	cpID = "gntn_cp",
		holdTime = 1,
		sets = {
		},
	},
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
