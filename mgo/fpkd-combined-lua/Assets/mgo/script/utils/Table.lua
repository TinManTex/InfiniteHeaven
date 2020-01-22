local this = {}





this.Merge = function( t1, t2 )
	for key,value in pairs( t2 ) do
		table.insert( t1, value )
	end

	return t1
end




this.Count = function( t, item )
	local count = 0
	for key,value in pairs(t) do
		if item == value then count = count + 1 end
	end
	return count
end




this.Uniquify = function( t )
	local uniqueTable = {}
	for key,value in pairs(t) do
		if( this.Count( uniqueTable, value ) == 0) then
			table.insert( uniqueTable, value )
		end
	end
	return uniqueTable
end

return this