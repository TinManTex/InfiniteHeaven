local s10010_demo = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




s10010_demo.demoList = {
	beforeOpening = "p21_000100",
	opening = "p21_010000",
	openingFlag = "p21_010000_tgt_flag",
	flashback = "p21_010020",
	firstDay = "p21_010040",
	fewDaysLater0 = "p21_010050",
	fewDaysLater1 = "p21_010050_001",
	fewDaysLater1_NG0 = "p21_010050_cmn_react000",
	fewDaysLater1_NG1 = "p21_010050_cmn_react001",
	fewDaysLater1_NG2 = "p21_010050_cmn_react002",
	fewDaysLater2 = "p21_010050_002",
	fewDaysLater2_Truth = "p21_010055_002",
	fewDaysLater2_NG0 = "p21_010050_001_react000",
	fewDaysLater2_NG1 = "p21_010050_cmn_react000",
	fewDaysLater2_NG2 = "p21_010050_cmn_react002",
	fewDaysLater3 = "p21_010050_003",
	fewDaysLater3_Truth = "p21_010055_003",
	oneWeekLater = "p21_010100",
	twoWeekLater = "p21_010200",
	twoWeekLater_Truth = "p21_010205",
	twoWeekLaterReflect = "p21_010200_reflect",
	souvenirPhotograph = "p81_000001",
	quietAppear = "p21_010230",
	quietAppearTruth = "p21_010235",
	ishmaelAppear = "p21_010240",
	quietExit = "p21_010250",
	heli = "p21_010260",
	volgin = "p21_010270",
	cure = "p21_010310",
	underBed = "p21_010340",
	underBed2 = "p21_010340_02",
	heliKillMob = "p21_010360",
	soldierKillMob = "p21_010370",
	stairway = "p21_010380",
	corridor0 = "p21_010410",
	corridor1 = "p21_010410_001",
	corridor2 = "p21_010410_002",
	corridor3 = "p21_010410_003",
	corridor4 = "p21_010410_004",
	corridor5 = "p21_010410_005",
	corridor6 = "p21_010410_006",
	corridor7 = "p21_010420_001",
	curtainRoom = "p21_010420",
	curtainRoom2 = "p21_010420_02",
	volginVsSkullSoldier = "p21_010440",
	getGun = "p21_010490",
	beforeEntrance = "p21_010500_001",
	entrance = "p21_010500_000_final",
	ambulance = "p21_010510",
	heliRotor = "p21_010520",
	tank = "p21_010530",
	volginVsTank = "p21_010540",
	escapeFromEntrance = "p21_010550",
	escapeFromHospital = "p21_020010",
	fireWhale = "p21_020030_000",
	passportPhotograph = "p81_000010",
	fireWhaleTruth = "p61_000030",
	bridge = "p21_020040",
	bridge2 = "p21_020040_001",
	twoBigBoss = "p61_000040",
}








s10010_demo.IsDemoName = function( demoName )
	if s10010_demo.demoList[ demoName ] then
		return true
	end
	return false
end

s10010_demo.truthDemoTable = {
	p21_010235 = "quietAppear",	
	p21_010055_002 = "fewDaysLater2",	
	p21_010055_003 = "fewDaysLater3",	
	p21_010205 = "twoWeekLater",	
}




s10010_demo.GetDemoNameFromDemoId = function( targetDemoId )

	
	for demoId, demoName in pairs( s10010_demo.truthDemoTable ) do
		if targetDemoId == StrCode32( demoId ) then
			return demoName
		end
	end

	for demoName, demoId in pairs( s10010_demo.demoList ) do
		if StrCode32( demoId ) == targetDemoId then
			return demoName
		end
	end

	return nil

end




s10010_demo.GetDemoIdFromDemoName = function( targetDemoName )

	
	if TppMission.GetMissionName() == "s10280" then
		for demoId, demoName in pairs( s10010_demo.truthDemoTable ) do
			if targetDemoName == demoName then
				return demoId
			end
		end
	end


	for demoName, demoId in pairs( s10010_demo.demoList ) do
		if targetDemoName == demoName then
			return demoId
		end
	end

	return nil

end

s10010_demo.PlayBeforeOpeningDemo = function( functionTable )
	Fox.Log( "s10010_demo.PlayBeforeOpeningDemo()" )
	TppDemo.Play( "beforeOpening", functionTable, { startNoFadeIn = true, finishFadeOut = true, } )
end

s10010_demo.PlayOpeningDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayOpeningDemo ####")
	TppDemo.Play( "opening", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayOpeningFlagDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayOpeningFlagDemo ####")
	TppDemo.Play( "openingFlag", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFlashBackDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFlashBackDemo ####")
	TppDemo.Play( "flashback", functionTable, { finishFadeOut = true, } )
end

s10010_demo.PlayFewDaysLater0 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater0 ####")
	TppDemo.Play( "fewDaysLater0", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater1 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater1 ####")
	TppDemo.Play( "fewDaysLater1", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater1_NG0 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater1_NG0 ####")
	TppDemo.Play( "fewDaysLater1_NG0", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater1_NG1 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater1_NG1 ####")
	TppDemo.Play( "fewDaysLater1_NG1", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater1_NG2 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater1_NG2 ####")
	TppDemo.Play( "fewDaysLater1_NG2", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater2 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater2 ####")
	TppDemo.Play( "fewDaysLater2", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater2_Truth = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater2_Truth ####")
	TppDemo.Play( "fewDaysLater2_Truth", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater2_NG0 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater2_NG0 ####")
	TppDemo.Play( "fewDaysLater2_NG0", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater2_NG1 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater2_NG1 ####")
	TppDemo.Play( "fewDaysLater2_NG1", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater2_NG2 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater2_NG2 ####")
	TppDemo.Play( "fewDaysLater2_NG2", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater3 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater3 ####")
	TppDemo.Play( "fewDaysLater3", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFewDaysLater3_Truth = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFewDaysLater3_Truth ####")
	TppDemo.Play( "fewDaysLater3_Truth", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayOneWeekLaterDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayOneWeekLaterDemo ####")
	TppDemo.Play( "oneWeekLater", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayTwoWeekLaterDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayTwoWeekLaterDemo ####")
	TppDemo.Play( "twoWeekLater", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayTwoWeekLaterDemo_Truth = function( functionTable )
	Fox.Log("#### s10010_demo.PlayTwoWeekLaterDemo_Truth ####")
	TppDemo.Play( "twoWeekLater_Truth", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlaySouvenirPhotograph = function( functionTable )
	Fox.Log("#### s10010_demo.PlaySouvenirPhotograph ####")
	TppDemo.Play( "souvenirPhotograph", functionTable, { startNoFadeIn = true, finishFadeOut = true } )
end

s10010_demo.PlayQuietAppearDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayQuietAppearDemo ####")
	TppDemo.Play( "quietAppear", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayQuietAppearTruthDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayQuietAppearTruthDemo ####")
	TppDemo.Play( "quietAppearTruth", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayIshmaelAppearDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayIshmaelAppearDemo ####")
	TppDemo.Play( "ishmaelAppear", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayQuietExitDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayQuietExitDemo ####")
	TppDemo.Play( "quietExit", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayHeliDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayHeliDemo ####")
	TppDemo.Play( "heli", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayVolginDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayVolginDemo ####")
	TppDemo.Play( "volgin", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCureDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCureDemo ####")
	TppDemo.Play( "cure", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayUnderBedDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayUnderBedDemo ####")
	TppDemo.Play( "underBed", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayUnderBed2Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayUnderBed2Demo ####")
	TppDemo.Play( "underBed2", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayHeliKillMobDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayHeliKillMobDemo ####")
	TppDemo.Play( "heliKillMob", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlaySoldierKillMobDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlaySoldierKillMobDemo ####")
	TppDemo.Play( "soldierKillMob", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayStairwayDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayStairwayDemo ####")
	TppDemo.Play( "stairway", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor0Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor0Demo ####")
	TppDemo.Play( "corridor0", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor1Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor1Demo ####")
	TppDemo.Play( "corridor1", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor2Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor2Demo ####")
	TppDemo.Play( "corridor2", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor3Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor3Demo ####")
	TppDemo.Play( "corridor3", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor4Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor4Demo ####")
	TppDemo.Play( "corridor4", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor5Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor5Demo ####")
	TppDemo.Play( "corridor5", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor6Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor6Demo ####")
	TppDemo.Play( "corridor6", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCorridor7Demo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCorridor7Demo ####")
	TppDemo.Play( "corridor7", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCurtainRoomDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCurtainRoomDemo ####")
	TppDemo.Play( "curtainRoom", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayCurtainRoomDemo2 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayCurtainRoomDemo2 ####")
	TppDemo.Play( "curtainRoom2", functionTable, { isInGame = true, startNoFadeIn = true, } )
end

s10010_demo.PlayVolginVsSkullSoldierDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayVolginVsSkullSoldierDemo ####")
	TppDemo.Play( "volginVsSkullSoldier", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayGetGunDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayGetGunDemo ####")
	TppDemo.Play( "getGun", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayBeforeEntranceDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayBeforeEntranceDemo ####")
	TppDemo.Play( "beforeEntrance", functionTable, { isInGame = true, } )
end

s10010_demo.PlayEntranceDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayEntranceDemo ####")
	TppDemo.Play( "entrance", functionTable, {  } )
end

s10010_demo.PlayVolginInEntranceDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayVolginInEntranceDemo ####")
	TppDemo.Play( "ambulance", functionTable, { enableSkipMenu = true, disableDemoEnemies = false,} )
end

s10010_demo.PlayHeliRotorDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayHeliRotorDemo ####")
	TppDemo.Play( "heliRotor", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayVolginVsTankDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayVolginVsTankDemo ####")
	TppDemo.Play( "volginVsTank", functionTable, { isInGame = true, enableSkipMenu = true, } )
end

s10010_demo.PlayTankDemo = function( functionTable )
	Fox.Log( "s10010_demo.PlayTankDemo()" )
	TppDemo.Play( "tank", functionTable, { isInGame = true, } )
end

s10010_demo.StopTankDemo = function( functionTable )
	Fox.Log( "s10010_demo.StopTankDemo()" )
	DemoDaemon.SkipAll()
	
end

s10010_demo.PlayEscapeFromEntranceDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayEscapeFromEntranceDemo ####")
	TppDemo.Play( "escapeFromEntrance", functionTable, { isInGame = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayEscapeFromHospital = function( functionTable )
	Fox.Log("#### s10010_demo.PlayEscapeFromHospital ####")
	TppDemo.Play( "escapeFromHospital", functionTable, { isInGame = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFireWhaleDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFireWhale ####")
	TppDemo.Play( "fireWhale", functionTable, { isInGame = true, startNoFadeIn = true, enableSkipMenu = true, } )
end

s10010_demo.PlayPassportPhotographDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayPassportPhotographDemo ####")
	TppDemo.Play( "passportPhotograph", functionTable, { isExecMissionClear = true, startNoFadeIn = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayFireWhaleTruthDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayFireWhaleTruthDemo ####")
	TppDemo.Play( "fireWhaleTruth", functionTable, { isExecMissionClear = true, finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayBridgeDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayBridgeDemo ####")
	TppDemo.Play( "bridge", functionTable, { finishFadeOut = true, enableSkipMenu = true, } )
end

s10010_demo.PlayBridgeDemo2 = function( functionTable )
	Fox.Log("#### s10010_demo.PlayBridgeDemo2 ####")
	TppDemo.Play( "bridge2", functionTable, { isExecMissionClear = true, startNoFadeIn = true, finishFadeOut = true, } )
end

s10010_demo.PlayTwoBigBossDemo = function( functionTable )
	Fox.Log("#### s10010_demo.PlayTwoBigBossDemo ####")
	TppDemo.Play( "twoBigBoss", functionTable, { isExecMissionClear = true, finishFadeOut = true, } )
end




return s10010_demo
