local this = {}

this.requires = {
	"/Assets/mgo/script/utils/Random.lua",
	"/Assets/mgo/script/utils/Table.lua",
}
















this.GenerateDynamicPackTable = function()

	local PackTable = {}
	table.insert( PackTable, "core" )

	
	PackTable = Table.Uniquify( PackTable )
	return PackTable
end

return this