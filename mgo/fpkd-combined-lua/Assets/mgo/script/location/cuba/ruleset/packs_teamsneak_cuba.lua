local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}

















this.GenerateDynamicPackTable = function()

	local PackTable = {}

	
	local A_DiscTableCandidate = {}
	table.insert( A_DiscTableCandidate, "discA_01" )
	table.insert( A_DiscTableCandidate, "discA_02" )
	table.insert( A_DiscTableCandidate, "discA_03" )
	table.insert( A_DiscTableCandidate, "discA_04" )
	
	
	local A_DiscTable = Random.Choose( A_DiscTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, A_DiscTable )

	
	local B_DiscTableCandidate = {}
	table.insert( B_DiscTableCandidate, "discB_01" )
	table.insert( B_DiscTableCandidate, "discB_02" )
	table.insert( B_DiscTableCandidate, "discB_03" )
	table.insert( B_DiscTableCandidate, "discB_04" )

	
	local B_DiscTable = Random.Choose( B_DiscTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, B_DiscTable )
	
	
	local PadTableCandidateA = {}
	table.insert( PadTableCandidateA, "pads_02" )
	table.insert( PadTableCandidateA, "pads_04" )

	
	local PadTableA = Random.Choose( PadTableCandidateA, 1 )
	PackTable = Table.Merge( PackTable, PadTableA )

	
	local PadTableCandidateB = {}
	table.insert( PadTableCandidateB, "pads_01" )
	table.insert( PadTableCandidateB, "pads_03" )

	
	local PadTableB = Random.Choose( PadTableCandidateB, 1 )
	PackTable = Table.Merge( PackTable, PadTableB )

	
	table.insert( PackTable, "core")
	
	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this