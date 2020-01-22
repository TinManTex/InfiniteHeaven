local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}
















this.GenerateDynamicPackTable = function()

	local PackTable = {}

	
	local DocsTableCandidate = {}
	table.insert( DocsTableCandidate, "config1" )
	
	
	
	local DocsTable = Random.Choose( DocsTableCandidate, 1 )
	PackTable = Table.Merge( PackTable, DocsTable )
	
	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this