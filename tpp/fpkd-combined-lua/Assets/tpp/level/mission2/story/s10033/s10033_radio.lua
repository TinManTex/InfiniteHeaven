local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	{ "s0033_rtrg0010", playOnce = true },
	{ "s0033_rtrg1010", playOnce = true },
	{ "f1000_rtrg3050", playOnce = true },
	{ "f1000_rtrg1130", playOnce = true },
	{ "f1000_rtrg2040", playOnce = true },
	{ "f1000_rtrg3060", playOnce = true },
	{ "f1000_rtrg3070", playOnce = true },
	"f1000_rtrg2250",
	"f1000_rtrg2270",
	{ "f1000_rtrg3080", playOnce = true },
	{ "f1000_rtrg3090", playOnce = true },
	{ "f1000_rtrg3095", playOnce = true },
	{ "f1000_rtrg1610", playOnce = true },
	{ "f1000_rtrg1615", playOnce = true },
	{ "f1000_rtrg2440", playOnce = true },
	{ "f1000_rtrg2330", playOnce = true },
	{ "f1000_rtrg2310", playOnce = true },
	{ "f1000_rtrg3110", playOnce = true },
	{ "s0033_rtrg3015", playOnce = true },
	{ "f1000_rtrg8050", playOnce = true },
	{ "f1000_rtrg8040", playOnce = true },
	"f1000_mprg0190",
	"f1000_mprg0080",
	"f1000_rtrg2070",
	"f1000_rtrg3170",
	"f1000_rtrg0750",
	
	
	
	
	test_MissionComplete_LeaveBase 	= {"(dbg)拠点から離れて安全を確保するんだ" ,},
	test_MissionComplete_KeepSafety = {"(dbg)そのまま安全を確保するんだ" ,},
	test_NearByBase 				= {"(dbg)敵の拠点に近い！離れるんだ！" ,},
	test_KeepSafety 				= {"(dbg)いいぞ！安全を維持するんだ！" ,},
}





this.optionalRadioList = {
	"Set_s0033_oprg0010",
	"Set_s0033_oprg0020",
	"Set_s0033_oprg0030",
	"Set_s0033_oprg0040",
}





this.intelRadioList = {
	rds_enemyBase_0000		= "f1000_esrg1470",		
	rds_enemyBase_0001		= "f1000_esrg1840",		
	rds_enemyBase_0002		= "f1000_esrg1850",		
	rds_enemyBase_0003		= "f1000_esrg1480",		
	
	type_eleGenerator		= "f1000_esrg1080",		
	
	rds_enemyBase_0004		= "f1000_esrg1860",		
	
	
	
	hos_s10033_0000			= "f1000_esrg0550",		
	hos_s10033_0001			= "f1000_esrg0770",		
}




this.blackTelephoneDisplaySetting = {
	f6000_rtrg0250 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10033/mb_photo_10033_010_1.ftex", 0.6 ,"cast_bionics_engineer"},
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10033_02.ftex", 7.0 },
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10033_03.ftex", 14.3 },
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10033/mb_photo_10033_010_1.ftex", 0.6,"cast_bionics_engineer" },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10033_02.ftex", 6.3 },
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10033_03.ftex", 13.7 },
		},
	},
}






this.MissionStart = function()
	Fox.Log("#### s10033_radio.MissionStart ####")
	TppRadio.Play( "s0033_rtrg0010" )
end

this.ArrivedEnemyBase = function()
	Fox.Log("#### s10033_radio.ArrivedEnemyBase ####")
	TppRadio.Play( "s0033_rtrg1010", { delayTime = "short" } )
end


this.GetUsefulRecord = function()
	Fox.Log("#### s10033_radio.GetRecord ####")
	TppRadio.Play( "f1000_rtrg3050" )
end

this.GetUselessRecord = function()
	Fox.Log("#### s10033_radio.CarryTarget ####")

	TppRadio.Play( "f1000_rtrg3095", { delayTime = "mid" } )
end


this.ArriveUnderBuilding = function()
	Fox.Log("#### s10033_radio.ArriveUnderBuilding ####")
	TppRadio.Play( "f1000_rtrg1130", { delayTime = "short" } )
end

this.EscapeUnderBuilding = function()
	Fox.Log("#### s10033_radio.EscapeUnderBuilding ####")
	TppRadio.Play( "f1000_rtrg2440", { delayTime = "short" } )
end


this.DiscoverUknownPOW = function()
	Fox.Log("#### s10033_radio.DiscoverUknownPOW ####")
	TppRadio.Play( "f1000_rtrg2040", { delayTime = "long" } )
end

this.RescueUsefulPOW = function()
	Fox.Log("#### s10033_radio.RescueUsefulPOW ####")
	TppRadio.Play( "f1000_rtrg3060", { delayTime = "long" } )
end

this.RescueUselessPOW = function()
	Fox.Log("#### s10033_radio.RescueUselessPOW ####")
	TppRadio.Play( "f1000_rtrg3070", { delayTime = "long" } )
end

this.LockingTarget = function()
	Fox.Log("#### s10033_radio.LockingTarget ####")
	TppRadio.Play( "f1000_rtrg2250", { delayTime = "short" } )
end

this.CanUnlockTarget = function()
	Fox.Log("#### s10033_radio.CanUnlockTarget ####")
	TppRadio.Play( "f1000_rtrg2270", { delayTime = "short" } )
end

this.CarryTarget = function()
	Fox.Log("#### s10033_radio.CarryTarget ####")
	TppRadio.Play( "f1000_rtrg3080", { delayTime = "long" } )
end

this.FailedFultonTarget1st = function()
	Fox.Log("#### s10033_radio.FailedFultonTarget1st ####")
	TppRadio.Play( "f1000_rtrg1610", { delayTime = "mid" } )
end

this.FailedFultonTarget2nd = function()
	Fox.Log("#### s10033_radio.FailedFultonTarget2nd ####")
	TppRadio.Play( "f1000_rtrg1615", { delayTime = "mid" } )
end

this.FailedFultonTargetDead = function()
	Fox.Log("#### s10033_radio.FailedFultonTargetDead ####")
	TppRadio.Play( "f1000_rtrg3120", { delayTime = "long" } )
end

this.NoticedBreakout = function()
	Fox.Log("#### s10033_radio.NoticedBreakout ####")
	TppRadio.Play( "f1000_rtrg2330", { delayTime = "short" } )
end

this.FoundTarget = function()
	Fox.Log("#### s10033_radio.FoundTarget ####")
	TppRadio.Play( "f1000_rtrg2310", { delayTime = "short" } )
end


this.RescueTargetOut = function()
	Fox.Log("#### s10033_radio.RescueTargetOut ####")
	TppRadio.Play( "f1000_rtrg3110", { delayTime = "long" } )
end

this.RescueTargetInn = function()
	Fox.Log("#### s10033_radio.RescueTargetInn ####")
	TppRadio.Play( "s0033_rtrg3015", { delayTime = "long" } )
end

this.CanBeCleared = function()
	Fox.Log("#### s10033_radio.CanBeCleared ####")
	TppRadio.Play( "f1000_rtrg8050" )
end

this.EnemiesAround = function()
	Fox.Log("#### s10033_radio.EnemiesAround ####")
	TppRadio.Play( "f1000_rtrg8040" )
end

this.OnGameCleared = function()
	Fox.Log("#### s10033_radio.OnGameCleared ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0250" )
end





this.changeESPR_D = function()
	Fox.Log("#### s10033_radio.changeESPR_D ####")
	TppRadio.ChangeIntelRadio{
		rds_enemyBase_0003		= "f1000_esrg1480",		
		
		type_eleGenerator		= "f1000_esrg1080",		
		
	}
end

this.changeESPR_N = function()
	Fox.Log("#### s10033_radio.changeESPR_N ####")
	TppRadio.ChangeIntelRadio{
		
		rds_enemyBase_0003		= "f1000_esrg1490",		
		
		type_eleGenerator		= "f1000_esrg1090",		
	}
end



return this
