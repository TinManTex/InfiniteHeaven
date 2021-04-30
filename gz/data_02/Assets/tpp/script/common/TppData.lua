local this = {}






this.GetArgument = function( argNum )
	TppCommon.DeprecatedFunction( "TppEventSequenceManagerCollector.GetMessageArg( argNum - 1 )" )
	if( argNum < 1 or argNum > 4 ) then



		return nil
	end
	return TppEventSequenceManagerCollector.GetMessageArg( argNum - 1 )
end


this.GetData = function( dataName, type )
	TppCommon.DeprecatedFunction( "manager:GetDataBodyFromEntityLink( dataName )" )
	type = type or "mission"
	return TppSequence.GetData( dataName, type )
end


this.GetPosition = function( dataName )
	TppCommon.DeprecatedFunction( "data:GetWorldTransform().translation" )
	local data = this.GetData( dataName )
	if( data == nil ) then return end

	if( data.data:IsKindOf( "TransformData" ) == false ) then



		return nil
	end
	return data:GetWorldTransform().translation
end


this.GetRotation = function( dataName )
	TppCommon.DeprecatedFunction( "data:GetWorldTransform().rotQuat" )
	local data = this.GetData( dataName )
	if( data == nil ) then return end

	if( data.data:IsKindOf( "TransformData" ) == false ) then



		return nil
	end
	return data:GetWorldTransform().rotQuat
end


this.Enable = function( characterID )
	TppCommon.DeprecatedFunction( "TppCharacterUtility.SetEnableCharacterId( characterID, true )" )
	TppCharacterUtility.SetEnableCharacterId( characterID, true )
end


this.Disable = function( characterID )
	TppCommon.DeprecatedFunction( "TppCharacterUtility.SetEnableCharacterId( characterID, false )" )
	TppCharacterUtility.SetEnableCharacterId( characterID, false )
end


this.ShowModel = function( dataName )
	TppCommon.DeprecatedFunction( "TppStaticModel.Show( staticModelData )" )
	this._DoModel( dataName, true )
end


this.HideModel = function( dataName )
	TppCommon.DeprecatedFunction( "TppStaticModel.Hide( staticModelData )" )
	this._DoModel( dataName, false )
end





this._DoModel = function( dataName, isDo )
	local data = this.GetData( dataName )
	if( data == nil ) then return end

	if( data.data:IsKindOf( "StaticModel" ) == false ) then



		return
	end

	data.isVisible = isDo
	data.isGeomActive = isDo
end




return this
