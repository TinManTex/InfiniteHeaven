local this = {}






this.Show = function( staticModelData )
	if( this._IsStaticModel( staticModelData ) == false ) then return end
	staticModelData.isVisible = true
	staticModelData.isGeomActive = true
end


this.Hide = function( staticModelData )
	if( this._IsStaticModel( staticModelData ) == false ) then return end
	staticModelData.isVisible = false
	staticModelData.isGeomActive = false
end





this._IsStaticModel = function( staticModelData )
	if( staticModelData == nil or staticModelData == Entity.Null() ) then



		return false
	elseif( staticModelData:IsKindOf( "StaticModelBody" ) == false ) then



		return false
	end
	return true
end




return this
