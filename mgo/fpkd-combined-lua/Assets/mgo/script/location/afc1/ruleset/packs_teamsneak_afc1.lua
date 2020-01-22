local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}

















this.GenerateDynamicPackTable = function()

	local PackTable = {}

	
	local DiscsTableCandidate = {}
	table.insert( DiscsTableCandidate, "discs1" )
	table.insert( DiscsTableCandidate, "discs2" )
	
	
	local DiscsTable = Random.Choose( DiscsTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, DiscsTable )
	
	
	local RetrievalTableCandidate = {}
	table.insert( RetrievalTableCandidate, "pad1" )
	table.insert( RetrievalTableCandidate, "pad2" )
	
	
	local RetrievalTable = Random.Choose( RetrievalTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, RetrievalTable )
	
	
	table.insert( PackTable, "core")

	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this