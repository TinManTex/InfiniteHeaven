local this = {}





this.Choose = function( t, count )
	local chooseTable = {}
	if count > #t then
		Fox.Error( "Random.Choose() was given table of size " .. #t .. " to select " .. count .. " items." )
		return chooseTable 
	end

	
	if not count then 
		count = 0 
	else
		count = #t - count 
	end
	while #t > count do
		local idx = math.random(1, #t)
		chooseTable[#chooseTable + 1] = t[idx]
		table.remove(t, idx)
	end
	return chooseTable
end

return this
