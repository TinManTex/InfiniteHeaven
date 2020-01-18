









TppTrapExecVolginCharge = {



Exec = function( info )
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		local volgin = Ch.FindCharacters( "Volgin" )
		if #volgin.array ~= 0 then
			local chara = volgin.array[1]
			local plgAttackAction = chara:FindPlugin( "AttackAction" )
			if Entity.IsNull( plgAttackAction ) then
				Ch.Warning( chara, "plgAttackAction == nil. Can't use Charge Attack.")
				return
			end
			plgAttackAction:UseChargeAttack()
		end
	end
	return 1
end,

}