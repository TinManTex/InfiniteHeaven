local this = {}






this.SplitString = function( str, pat )
	local retVal = {}
	local index
	local subStr = str

	while( true ) do
		index = string.find( subStr, pat )
		if( index == nil ) then
			table.insert( retVal, subStr )
			break
		else
			local tmpStr = string.sub( subStr, 0, index - 1 )
			table.insert( retVal, tmpStr )
			subStr = string.sub( subStr, index + 1 )
		end
	end

	return retVal
end


this.IsIncluded = function( tbl, item )
	for i = 1, #tbl do
		if( item == tbl[i] ) then
			return true
		end
	end
	return false
end


this.InvertTable = function( tbl )
	local retVal = {}
	for k, v in pairs( tbl ) do
		retVal[v] = k
	end
	return retVal
end


this.GetValueIndex = function( tbl, value )
	local invertTable = this.InvertTable( tbl )
	return invertTable[value]
end



this.FindDistance = function( point1, point2 )
	local x1 = point1:GetX()
	local y1 = point1:GetY()
	local z1 = point1:GetZ()

	local x2 = point2:GetX()
	local y2 = point2:GetY()
	local z2 = point2:GetZ()

	local xDist = ( x2 - x1 ) ^ 2
	local yDist = ( y2 - y1 ) ^ 2
	local zDist = ( z2 - z1 ) ^ 2
	local dist = xDist + yDist + zDist

	
	return dist
end


this.SetPreference = function( prefName, propName, propValue )
	local pref = Preference.GetPreferenceEntity( prefName )
	if( pref == nil ) then



		return
	end
	if( pref[propName] == nil ) then



		return
	end
	Command.SetProperty{ entity = pref, property = propName, value = propValue }
end




return this
