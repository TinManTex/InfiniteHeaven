local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}

















this.GenerateDynamicPackTable = function()

	local PackTable = {}

	
	local AnimTableCandidate = {}
	table.insert( AnimTableCandidate, "config1" )
	table.insert( AnimTableCandidate, "config2" )
	
	
	local AnimTable = Random.Choose( AnimTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, AnimTable )


	
	table.insert( PackTable, "core")
	
	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this