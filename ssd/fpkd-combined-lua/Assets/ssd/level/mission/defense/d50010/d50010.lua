




local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseBaseDigging.CreateInstance( "d50010" )

this.radioSettings = {
	startWave = { "f3000_rtrg1502" },
	clearDefense = { "f3000_rtrg1507" },
	failureDefense = { "f3000_rtrg1509" },
}


this.waveLimitTimeTable = {
	(60 * 7),
	(60 * 8),
	(60 * 9),
	(60 * 10),
	(60 * 12),
}


this.waveIntervalTable = {
	12,
	24,
	48,
	72
}


this.rewardTable = {
	rewards = {
		rankS = {
			{ Fox.StrCode32( "RCP_EQP_WP_Baton_A" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_StunBat" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_F" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Hammer_A" ), "Recipe", 1 },
		},
		rankA = {
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_C" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_D" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_DrillSpear" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_CompoundBow" ), "Recipe", 1 },
		},
		rankB = {
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_B" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_StrongCrowBar" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Axe_A" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_FireBat" ), "Recipe", 1 },
		},
		rankC = {
			{ Fox.StrCode32( "RCP_EQP_WP_Scoop_A" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_E" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_StunRod_A" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_BattleAxe" ), "Recipe", 1 },
		},
		rankD = {
			{ Fox.StrCode32( "RES_Wood" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Iron" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Nail" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Rag" ), "Resource", 20 },
		},
		rankE = {
			{ Fox.StrCode32( "RES_Wood" ), "Resource", 10 },
			{ Fox.StrCode32( "RES_Iron" ), "Resource", 10 },
			{ Fox.StrCode32( "RES_Nail" ), "Resource", 10 },
			{ Fox.StrCode32( "RES_Rag" ), "Resource", 10 },
		},
	},
	
	
	lotteryCount = {
		2, 2, 2, 2, 4, 4
	},
	
	
	rankThreashold = {
		50000, 40000, 30000, 20000, 10000
	},
	
	waveRewards = {
		{
			
			{ Fox.StrCode32( "RES_Wood" ), "Resource", 10 },
			{ Fox.StrCode32( "RES_Iron" ), "Resource", 10 },
			{ Fox.StrCode32( "RES_Nail" ), "Resource", 10 },
		},
		{
			
			{ Fox.StrCode32( "RES_Wood" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Iron" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Nail" ), "Resource", 20 },
			{ Fox.StrCode32( "RES_Rag" ), "Resource", 20 },
		},
		{
			
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_B" ), "Recipe", 1 },
		},
		{
			
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_C" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_CompoundBow" ), "Recipe", 1 },
		},
		{
			
			{ Fox.StrCode32( "RCP_EQP_WP_Baton_A" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_StunBat" ), "Recipe", 1 },
			{ Fox.StrCode32( "RCP_EQP_WP_Machete_F" ), "Recipe", 1 },
		},
	},
}

return this
