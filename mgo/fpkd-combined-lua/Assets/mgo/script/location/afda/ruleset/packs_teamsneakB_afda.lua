local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}
















this.GenerateDynamicPackTable = function()

	local PackTable = {}

	
	local TDMTableCandidate = {}
	table.insert( TDMTableCandidate, "config1" )
	
	
	local TDMTable = Random.Choose( TDMTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, TDMTable )
	
	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this