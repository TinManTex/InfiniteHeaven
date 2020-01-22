local this = {}

this.SetReviveConfig = function(ruleset)

	local reviveConfig = {
		
			DownState = {
				
				Enabled						= false,

				
				HealthPercent				= 0.2,

				
				CanBeKilled					= true,

				
				MaxWait						= 60,
				
				
				EnableAbortWait				= true,

				
				MinWait						= 10,

				
				CallForHelpInterval			= 5,

				
				CallForHelpTimerate			= 2,

				
				CallforHelpRadius			= 60,

				
				MaxReviveTime				= 30,

				
				RateIncreasePer				= 0.5,

				
				RateDecrease				= 1,

				
				RateMax						= 5,

				
				InvincibleTime				= 5,
			},
	}

	ruleset:ReloadRulesetConfig(reviveConfig)
end

this.SetCloakingConfig = function(ruleset)

	local cloakConfig = {
		Cloaking = {
			
			BaseOpaqueness = 0.375,
			
			
			LocalAddOpaqueness = 0.15,
		},
	}

	ruleset:ReloadRulesetConfig(cloakConfig)
end

return this