local this = {}






this.CreateEffect = function( effectInstanceName, options )



	options = options or {}

	if ( options.useGroup == true ) then
		TppDataUtility.CreateEffectFromGroupId( effectInstanceName )
	else
		TppDataUtility.CreateEffectFromId( effectInstanceName )
	end
end


this.ShowEffect = function( effectInstanceName, options )



	options = options or {}

	this._SetVisible( effectInstanceName, options.useGroup, true )
end


this.HideEffect = function( effectInstanceName, options )



	options = options or {}

	this._SetVisible( effectInstanceName, options.useGroup, false )
end


this.EnableAreaFog = function( dataName )



	
	this._SetEnableAreaFog( dataName, true )
end


this.DisableAreaFog = function( dataName )



	
	this._SetEnableAreaFog( dataName, false )
end






this.EnableDamageFilter = function()
	TppEffectUtility.SetDamageBurnFilterVisibility( true )
end


this.DisableDamageFilter = function()
	TppEffectUtility.SetDamageBurnFilterVisibility( false )
end





this._SetVisible = function( effectInstanceName, useGroup, visible )
	if ( useGroup == true ) then
		TppDataUtility.SetVisibleEffectFromGroupId( effectInstanceName, visible )
	else
		TppDataUtility.SetVisibleEffectFromId( effectInstanceName, visible )
	end
end

this._SetEnableAreaFog = function( dataName, enable )
	TppVolumetricFogManager:SetEnableAreaFog( dataName, enable )
end




return this
