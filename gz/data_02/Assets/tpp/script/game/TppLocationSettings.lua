local this = {}




this.Times = {
}

this.RouteSets = {
}






this.GetTimes = function( locationName )
	return this.Times[locationName]
end


this.GetRouteSets = function( locationName )
	return this.RouteSets[locationName]
end




return this