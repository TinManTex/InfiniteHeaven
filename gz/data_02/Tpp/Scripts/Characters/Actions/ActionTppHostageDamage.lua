ActionTppHostageDamage = {


WakeUpStates = {
	"*",
},

OnLoad = function( plugin )

	if plugin.needTurn == nil then
		plugin:AddProperty( "bool", "needTurn", 1 )
	end
	plugin.needTurn = false

end,

OnWakeUp = function( plugin )
	
	local chara = plugin:GetCharacter()
	
	local plgDamageModule = chara:FindPlugin( "TppDamageModulePlugin" )
	plgDamageModule:EnableModule();

end,

OnSleep = function( plugin )
	

end,

OnPreControl = function( plugin )
	
		
	local chara = plugin:GetCharacter() 
	local plgBody = plugin:GetBodyPlugin()

	
	local plgDamageModule = chara:FindPlugin( "TppDamageModulePlugin" )
	if plugin.needTurn == true then
		plgDamageModule:EnableRot()
	else
		plgDamageModule:DisableRot()
	end
	plugin.neetTurn = false
		
	
	plugin.isSkipReaction = false
	
	if plgBody:IsOnGround() then
	










	
		if not plgBody:CompAnimGraphCurrentTag( plugin:GetLayerName(), "KeepDamage" ) then 
			if plgBody:IsTransitionMotionEnd( "Lower" ) then 
				plugin:SleepRequest()
			end
		else

		end
		
	else
		if plgBody:IsTransitionMotionEnd( "Lower" ) then
			if heightFromFloor > 1.5 then
				
			end
		end
	end


end,

}