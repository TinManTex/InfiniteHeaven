local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local NULL_ID = GameObject.NULL_ID
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString

local sequences = {}

local PlayerDisableActionFlagDefault = PlayerDisableAction.KILLING_WEAPON
local PlayerDisableActionFlagInBirdCage = PlayerDisableAction.KILLING_WEAPON + PlayerDisableAction.FULTON










local VISIBLE_ANIMALS = {
	{ TppMotherBaseManagementConst.ANIMAL_100, "TppWolf", "anml_wolf_00", nil, animalKey = "Wolf", isGot = false },				
	{ TppMotherBaseManagementConst.ANIMAL_110, "TppJackal", "anml_jackal_00", 1, animalKey = "Jackal", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_120, "TppJackal", "anml_jackal_01", 0, animalKey = "Jackal", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_130, "TppJackal", "anml_jackal_02", 2, animalKey = "Jackal", isGot = false }, 		

	{ TppMotherBaseManagementConst.ANIMAL_200, "TppZebra", "anml_Zebra_00", 0, animalKey = "Zebra", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_210, "TppZebra", "anml_Zebra_01", 2, animalKey = "Zebra", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_220, "TppZebra", "anml_Zebra_02", 1, animalKey = "Zebra", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_600, "TppBear", "anml_bear_00", 0, animalKey = "Bear", isGot = false },				
	{ TppMotherBaseManagementConst.ANIMAL_610, "TppBear", "anml_bear_01", 1, animalKey = "Bear", isGot = false },				

	{ TppMotherBaseManagementConst.ANIMAL_1200, "TppEagle", "anml_eagle_00", 0, animalKey = "Bird", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_1210, "TppEagle", "anml_eagle_01", 1, animalKey = "Bird", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_1220, "TppEagle", "anml_eagle_02", 2, animalKey = "Bird", isGot = false },			
	{ { TppMotherBaseManagementConst.ANIMAL_1400, TppMotherBaseManagementConst.ANIMAL_1403 }, "TppRat", "anml_rat_00", 0, animalKey = "Rat", isGot = false },	
	{ TppMotherBaseManagementConst.ANIMAL_1410, "TppRat", "anml_rat_01", 1, animalKey = "Rat", isGot = false },					
	{ TppMotherBaseManagementConst.ANIMAL_1420, "TppRat", "anml_rat_02", 2, animalKey = "Rat", isGot = false },					
	{ TppMotherBaseManagementConst.ANIMAL_1430, "TppRat", "anml_rat_03", 3, animalKey = "Rat", isGot = false },					

	{ { TppMotherBaseManagementConst.ANIMAL_1900, TppMotherBaseManagementConst.ANIMAL_1913 } , "TppGoat", "anml_goat_00", 1, animalKey = "Goat", isGot = false }, 		
	{ { TppMotherBaseManagementConst.ANIMAL_1920, TppMotherBaseManagementConst.ANIMAL_1933 }, "TppGoat", "anml_goat_01", 0, animalKey = "Goat", isGot = false },		
	{ { TppMotherBaseManagementConst.ANIMAL_1940, TppMotherBaseManagementConst.ANIMAL_1957 }, "TppNubian", "anml_nubian_00", 1, animalKey = "Nubian", isGot = false },	
	{ { TppMotherBaseManagementConst.ANIMAL_1960, TppMotherBaseManagementConst.ANIMAL_1977}, "TppNubian", "anml_nubian_01", 0, animalKey = "Nubian", isGot = false },	
	{ TppMotherBaseManagementConst.ANIMAL_2200, "TppCritterBird", "anml_Critter_00", 0, animalKey = "Bird", isGot = false },	
	{ TppMotherBaseManagementConst.ANIMAL_2210, "TppCritterBird", "anml_Critter_01", 1, animalKey = "Bird", isGot = false },	
	{ TppMotherBaseManagementConst.ANIMAL_2240, "TppStork", "anml_Stork_00", 1, animalKey = "Bird", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_2241, "TppStork", "anml_Stork_01", 0, animalKey = "Bird", isGot = false },			
	{ TppMotherBaseManagementConst.ANIMAL_2250, "TppStork", "anml_Stork_02", 2, animalKey = "Bird", isGot = false },			
}

local DAY_NIGHT_ROUTE_ANIMALS = {
	Wolf = { groupNumber = 1, morningMsg = nil, nightMsg = nil },		
	Jackal = { groupNumber = 3, morningMsg = nil, nightMsg = nil },		
	Zebra = { groupNumber = 3, morningMsg = nil, nightMsg = nil },		
	Bear = { groupNumber = 2, morningMsg = nil, nightMsg = nil },		
	Rat = { groupNumber = 4, morningMsg = nil, nightMsg = nil },		
	
	Goat = { groupNumber = 2, morningMsg = nil, nightMsg = nil }, 		
	Nubian = { groupNumber = 2, morningMsg = nil, nightMsg = nil },		
}

local animalGroupCount = 0
local dayNightRouteAlreadySetList = {}






local platformTelopTable = {
	{ "platform01", "platform_zoo_bird",		"platform_en_zoo_bird", },				
	{ "platform02", "platform_zoo_herbivore1",	"platform_en_zoo_herbivore1", },		
	{ "platform03", "platform_zoo_canivore",	"platform_en_zoo_canivore", },			
	{ "platform04", "platform_zoo_herbivore2",	"platform_en_zoo_herbivore2", },		
}


local TRAP_NAME_LIST = {
	"trap_telop_0000",
	"trap_telop_0001",
	"trap_telop_0002",
	"trap_telop_0003",
}


local HELI_ROUTE_LIST = {
	{ routeId = "ly500_cl00_30150_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr", },
	{ routeId = "ly500_cl00_30150_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr", },
	{ routeId = "ly500_cl00_30150_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr", },
	{ routeId = "ly500_cl00_30150_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr", },
}


local HORSE_POS_LIST = {
	{ pos = Vector3( 14.932, 0.000, -28.541 ),		rotY = 0		},
	{ pos = Vector3( 145.247, 0.000, 15.846 ),		rotY = -1.5		},
	{ pos = Vector3( -124.832, 0.000, 86.094 ),		rotY = 130		},
	{ pos = Vector3( -89.753, 0.000, -125.093 ),	rotY = -130		},
}

local telopSettingTable = {}





this.NO_MISSION_TELOP_ON_START_HELICOPTER = true 





this.missionStartPosition = {
	helicopterRouteList = {},
}








function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		
		"Seq_Game_MainGame",
		"Seq_Game_Escape",
		
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end





this.saveVarsList = {
	isBuddyLoad			= false,
	missionStartBuddy	= 0,
}


this.checkPointList = {
	nil
}












function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")
	
	
	
	local systemCallbackTable ={
		OnEstablishMissionClear = TppMission.MissionGameEnd,
		OnDisappearGameEndAnnounceLog = TppMission.MissionFinalize,
		nil
	}
	
	TppMission.RegisterMissionSystemCallback(systemCallbackTable)
	
end

function this.OnEndMissionPrepareSequence()
	
	TppUiStatusManager.SetStatus(	"EquipHudAll", "ALL_KILL_NOUSE" )
end




function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")
	
	
	vars.playerDisableActionFlag = PlayerDisableActionFlagDefault
	
	
	this.ShowGotAnimals()
		
	
	this.SetCasseteTape()
	
	
	this.SetEmblem()
	
	
	if svars.isBuddyLoad == true then
		TppBuddy2BlockController.Load()
	end
	
end




function this.AcceptMission( missionId )
	local grade = TppLocation.GetMbStageClusterGrade( TppDefine.CLUSTER_DEFINE.Develop + 1 )
	local s10115_heliRouteTable = {
		[1] = { "ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr", Vector3(878.28747558594,-3.498596906662,323.64611816406) },
		[2] = { "ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr", Vector3(974.13403320313,-3.498596906662,326.39437866211) },
		[3] = { "ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr", Vector3(1043.8511962891,-3.498596906662,260.56399536133) },
		[4] = { "ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr", Vector3(1191.4196777344,-3.498596906662,259.04104614258) },
	}
	
	TppMission.AcceptMissionOnMBFreeMission( missionId, grade, s10115_heliRouteTable )
end


function this.OnTerminate()
	Fox.Log("*** OnTerminate ***")
	

	
end



function this.SetCasseteTape()
	local isBirdCassete = false
	local isGoatCassete = false
	local isZebraCassete = false
	local isWolfCassete = false
	local isBearCassete = false
	
	for k, visibleAnimalsTable in pairs( VISIBLE_ANIMALS ) do
		Fox.Log( "## " .. k .. " animalKey: " .. visibleAnimalsTable.animalKey )
		
		if visibleAnimalsTable.isGot == true then
			if visibleAnimalsTable.animalKey == "Bird" then
				isBirdCassete = true 
			elseif visibleAnimalsTable.animalKey == "Goat" then
				isGoatCassete = true 
			elseif visibleAnimalsTable.animalKey == "Zebra" or visibleAnimalsTable.animalKey == "Nubian" then
				isZebraCassete = true 
			elseif visibleAnimalsTable.animalKey == "Wolf" or visibleAnimalsTable.animalKey == "Jackal" then
				isWolfCassete = true 
			elseif visibleAnimalsTable.animalKey == "Bear" then
				isBearCassete = true 
			end
		end
	end

	
	TppPickable.SetEnableByLocatorName( "itm_cassette_30150_0000", isBirdCassete )
	TppPickable.SetEnableByLocatorName( "itm_cassette_30150_0001", isGoatCassete )
	TppPickable.SetEnableByLocatorName( "itm_cassette_30150_0002", isZebraCassete )
	TppPickable.SetEnableByLocatorName( "itm_cassette_30150_0003", isWolfCassete )
	TppPickable.SetEnableByLocatorName( "itm_cassette_30150_0004", isBearCassete )
end

function this.SetEmblem()
	local nShowflag = 0
	if TppUiCommand.HasEmblemTexture( "front11" ) then
		nShowflag = 1
	else
		nShowflag = 0
	end
	TppCollection.RepopCountOperation( "SetAt", "col_develop_MTBS_30150_0000", nShowflag )
end




local messagesTable = StrCode32Table {
	Player = {
		{	
			msg = "OnPlayerHeliHatchOpen",
			func = function()




























			end
		},
		{	
			msg = "RideHelicopter",
			func = function( gameObjectId )
				if Tpp.IsPlayer( gameObjectId ) then
					
					mtbs_baseTelop.DisableBaseName()
				end
			end,
		},
	},
	GameObject = {
		{	
			msg = "HeliDoorClosed", sender = "SupportHeli",
			func = function ()
				Fox.Log("Mission clear : on Heli")
				
				this.ReserveMissionClear()
			end
		},
	},
	Trap = {
		{	
			msg = "Enter",
			sender = "trap_FultonOff",
			func = function( trapId )
				vars.playerDisableActionFlag = PlayerDisableActionFlagInBirdCage
			end
		},
		{	
			msg = "Enter",
			sender = "trap_FultonOn",
			func = function( trapId )
				vars.playerDisableActionFlag = PlayerDisableActionFlagDefault
			end
		},
	},
	nil
}

function this.OnSelectLandPointTaxi(nextMissionId, routeName, layout, clusterId)
	if nextMissionId == 30250 then
		clusterId = 7
	end
	Fox.Log("missionId: " ..tostring(nextMissionId)  .. " :routeName: " ..tostring(routeName) .. " :layout:" .. tostring(layout) .. " :clusterId: " .. tostring(clusterId) )
	this.ReserveMissionClear(nextMissionId, routeName, layout, clusterId )
	TppMission.SetIsStartFromHelispace()
	TppMission.ResetIsStartFromFreePlay()
end

function this.ReserveMissionClear(nextMissionId, nextHeliRoute, nextLayoutCode, nextClusterId )
	local missionClearType = TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR
	if nextMissionId == nil then 
		nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER
		nextLayoutCode = nil
		nextClusterId = nil
	end
	
	TppMission.ReserveMissionClear{
		missionClearType = missionClearType,
		nextMissionId = nextMissionId,
		nextHeliRoute = nextHeliRoute,
		nextLayoutCode = nextLayoutCode,
		nextClusterId = nextClusterId,
	}
	
	TppHero.SetOgrePoint( -300 )
end




function this.Messages()
	
	this.SetRegisteredVisibleAnimalTable()
	this.RegisterClockMessages()
	
	if TppAnimalBlock.weatherTable then
		local clockMessage = Tpp.StrCode32Table{ Weather = TppAnimalBlock.weatherTable }
		messagesTable = Tpp.MergeTable( messagesTable, clockMessage, false )
	end
	local messageT = messagesTable
	return messagesTable
end





sequences.Seq_Game_MainGame = {
	Messages = function( self ) 
		return
		StrCode32Table {
			Terminal = {
				{
					msg = "MbDvcActAcceptMissionList", func = this.AcceptMission,
				},
				{
					msg = "MbDvcActSelectLandPointTaxi", func = this.OnSelectLandPointTaxi,
				},
			},
		}
	end,

	OnEnter = function()
		
		TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_TAXI_CHANGE_LOCATION" )
	end,

	OnLeave = function ()
	end,
}

sequences.Seq_Game_Escape = {

	OnEnter = function()
	end,
}






function this.SetRegisteredVisibleAnimalTable()
	
	for k, v in pairs( VISIBLE_ANIMALS ) do
		Fox.Log( "## " .. k .. " animalKey: " .. v.animalKey )
		local mbAnimalId = v[1]
		local mbAnimalRangeMaxId = nil
		
		if IsTypeTable( mbAnimalId ) then
			mbAnimalId = v[1][1]
			mbAnimalRangeMaxId = v[1][2]
		end	
		
		
		local isEnabled = TppMotherBaseManagement.IsGotDataBase{ dataBaseId = mbAnimalId }
		
		if not isEnabled and mbAnimalRangeMaxId then
			for i = mbAnimalId+1, mbAnimalRangeMaxId do
				Fox.Log( "SetRegisteredVisibleAnimalTable: This Animal Has Variation. MB Animal ID: " .. i )
				isEnabled = TppMotherBaseManagement.IsGotDataBase{ dataBaseId = i }
				
				if isEnabled then
					break
				end
			end
		end
		
		
		if isEnabled then
			v.isGot = true
		end
	end
end


function this.RegisterClockMessages()

	
	this.InitializeAnimalRegistration()
	TppAnimalBlock.weatherTable = {}
	
	for k, v in pairs( VISIBLE_ANIMALS ) do
		Fox.Log( "## " .. k .. " animalKey: " .. v.animalKey )
		
		if v.isGot == true then
			local animalType = v.animalKey
			if animalType ~= "Rat" and animalType ~= "Bird" then
				local selectSetUpTable = TppAnimalBlock._GetSetupTable( animalType )
				if selectSetUpTable ~= nil and animalType ~= "NoAnimal" then
					
					for animalTypeName, animalSetting in pairs( DAY_NIGHT_ROUTE_ANIMALS ) do						
						
						if animalTypeName == animalType then							
							if dayNightRouteAlreadySetList[ animalTypeName ] == false then
								
								if animalSetting.morningMsg then
									TppClock.UnregisterClockMessage( animalSetting.morningMsg )
									animalSetting.morningMsg = nil
								end
								if animalSetting.nightMsg then
									TppClock.UnregisterClockMessage( animalSetting.nightMsg )
									animalSetting.nightMsg = nil
								end
	
								Fox.Log( "#RegisterClockMessages animalType: " .. animalType .. ", animalSetting.Group: " .. animalSetting.groupNumber )
								this._AddClockMessage( animalType, animalGroupCount, this._ChangeRouteAtTime )
								
								local currentAnimalGroupCount = animalSetting.groupNumber or 0
								animalGroupCount = animalGroupCount + currentAnimalGroupCount
						
								dayNightRouteAlreadySetList[ animalTypeName ] = true	
							end
						end
					end
				end
			end
		end
	end
end

function this._AddClockMessage( animalType, animalGroupCount, changeRouteFunc )

	local animalDefaultTimeTable = TppAnimalBlock.GetDefaultTimeTable( animalType )
	local nightStartTime = animalDefaultTimeTable.nightStartTime
	local nightStartClock = TppClock.ParseTimeString( nightStartTime, "number" )
	local nightEndTime = animalDefaultTimeTable.nightEndTime
	local nightEndClock = TppClock.ParseTimeString( nightEndTime, "number" )
	local timeLag = TppAnimalBlock.GetDefaultTimeTable( animalType ).timeLag
	local timeLagClock = TppClock.ParseTimeString( timeLag, "number" )
	
	
	DAY_NIGHT_ROUTE_ANIMALS[animalType].nightMsg = TppAnimalBlock._RegisterClockMessage( TppAnimalBlock.CLOCK_MESSAGE_AT_NIGHT_FORMAT, nightStartClock, timeLagClock, true, animalGroupCount, changeRouteFunc )

	
	DAY_NIGHT_ROUTE_ANIMALS[animalType].morningMsg = TppAnimalBlock._RegisterClockMessage( TppAnimalBlock.CLOCK_MESSAGE_AT_MORNING_FORMAT, nightEndClock, timeLagClock, false, animalGroupCount, changeRouteFunc )
end


function this.ShowGotAnimals()

	
	this.InitializeAnimalRegistration()
		
	for k, v in pairs( VISIBLE_ANIMALS ) do
		Fox.Log( "## " .. k .. " animalKey: " .. v.animalKey )
		
		local mbAnimalId = v[1]
		local mbAnimalRangeMaxId = nil
		
		if IsTypeTable( mbAnimalId ) then
			mbAnimalId = v[1][1]
			mbAnimalRangeMaxId = v[1][2]
		end	
		
		local animalType = v[2]
		local locatorName = v[3]
		local fovaIndex = v[4]
		
		
		local isEnabled = v.isGot
		TppAnimal.SetEnabled( animalType, locatorName, isEnabled )
		
		if isEnabled == true then
			
			TppAnimal.SetKind( animalType, locatorName, fovaIndex )
			
			
			local randSeed = math.random( 1, WeatherManager.GetCurrentClock() )
			TppAnimal.SetFova( animalType, locatorName, nil, randSeed )
			
			
			this.SetRoute( v )
			
			
			this.SetBirdBehavior( v.animalKey, animalType, locatorName )
			
		end
	end
	
	
	this.SetIgnoreNotice()
	
end

function this.InitializeAnimalRegistration()
	animalGroupCount = 0
	for k, v in pairs( DAY_NIGHT_ROUTE_ANIMALS ) do
		dayNightRouteAlreadySetList[ k ] = false 
	end
end


function this.SetRoute( animalTypeValue )
	local animalType = animalTypeValue.animalKey

	
	if animalType == "Bird" then
		return
	end
	
	local selectSetUpTable = TppAnimalBlock._GetSetupTable( animalType )
	if selectSetUpTable ~= nil and animalType ~= "NoAnimal" then
		
		for k, v in pairs( DAY_NIGHT_ROUTE_ANIMALS ) do
			if k == animalType then	
				if dayNightRouteAlreadySetList[ k ] == false then
					local animalSetting = v
					Fox.Log( "animalType: " .. animalType .. ", animalSetting.Group: " .. animalSetting.groupNumber )

					if animalType == "Rat" then
						this._SetRatRoute( animalType, animalSetting, selectSetUpTable )
					else
						TppAnimalBlock._InitializeCommonAnimalSetting( animalType, animalSetting, selectSetUpTable )

						local currentAnimalGroupCount = animalSetting.groupNumber or 0
						animalGroupCount = animalGroupCount + currentAnimalGroupCount
					end
					dayNightRouteAlreadySetList[ k ] = true	
				end
			end
		end
	end
end


function this._ChangeRouteAtTime( senderName, time )
	Fox.Log( "_ChangeRouteAtTime: " .. tostring( senderName ) .. ": Current time is " .. TppClock.FormalizeTime( time, "string" ) )

	local animalType = nil
	local animalSetting = nil
	for animalTypeKey, animalTypeValue in pairs( DAY_NIGHT_ROUTE_ANIMALS ) do
		local currentAnimalType = animalTypeKey
		local currentAnimalSetting = animalTypeValue

		
		local isNeedChangeRouteAnimal = false
		if animalTypeValue.morningMsg == senderName or animalTypeValue.nightMsg == senderName then
			isNeedChangeRouteAnimal = true
		end
		
		if isNeedChangeRouteAnimal then
	
			local currentAnimalGroupCount = currentAnimalSetting.groupNumber or 0

			
			local isNight = TppAnimalBlock._IsNightForAnimalType( currentAnimalType, time )

			local animalSetupTable = TppAnimalBlock._GetSetupTable( currentAnimalType )
			if animalSetupTable == nil then
				Fox.Error( "failed TppAnimalBlock._ChangeRouteAtTime()" )
				return
			end

			for selectIndex = 0, ( currentAnimalGroupCount - 1) do
				if currentAnimalType == "Bear" then
					if isNight then
						TppAnimalBlock._SetRoute( animalSetupTable.type, animalSetupTable.locatorFormat, animalSetupTable.nightRouteFormat, selectIndex )
					else
						TppAnimalBlock._SetRoute( animalSetupTable.type, animalSetupTable.locatorFormat, animalSetupTable.routeFormat, selectIndex )
					end
				else
					if isNight then
						TppAnimalBlock._SetHerdRoute( animalSetupTable.type, animalSetupTable.locatorFormat, animalSetupTable.nightRouteFormat, selectIndex )
					else
						TppAnimalBlock._SetHerdRoute( animalSetupTable.type, animalSetupTable.locatorFormat, animalSetupTable.routeFormat, selectIndex )
					end
				end
				Fox.Log( "ChangeRoute animal[" .. tostring( animalSetupTable.type ) .. "] locatorIndex[".. tostring( selectIndex ) .. "] isNight[" .. tostring( isNight ) .. "]" )
			end
		
		end
	end
end


this._SetRatRoute = function( animalType, animalSetting, animalSetupTable )	

	local gameObjectId = { type = animalSetupTable.type, index = 0 }
	if gameObjectId == NULL_ID then
		Fox.Error("Cannot find gameObjectId.")
		return
	end
	
	local locatorFormat = animalSetupTable.locatorFormat
	local routeFormat = animalSetupTable.routeFormat

	local groupNumber = animalSetting.groupNumber
	for groupIndex = 0, ( groupNumber - 1 ) do
		local locatorName = string.format( locatorFormat , groupIndex )
		local routeName = string.format( routeFormat , groupIndex )
		
		local command = {
			id				= "SetRoute",				
			name			= locatorName,				
			ratIndex		= 0,						
			nodeIndex		= 0,						
			route			=  routeName,				
		}
		Fox.Log( "_SetRatRoute locatorName:" ..tostring( locatorName ) .. " routeName:" ..tostring( routeName ) )
		GameObject.SendCommand( gameObjectId, command )
	end
end


function this.SetBirdBehavior( animalKey, animalType, locatorName )

	
	if animalKey ~= "Bird" then
		return
	end

	
	local gameObjectId = { type = animalType, index = 0 }
	local command = {
			id = "SetParameter",
			name = locatorName,
			maxSpeed = 35.0,
			minSpeed = 18.0,
			flyTime = 20.0,         
			idleTime = 100.0,        
	}
	GameObject.SendCommand( gameObjectId, command )
	
	local perchCommand = {
		id = "WarpOnPerch",
		name = locatorName,
	}
	GameObject.SendCommand( gameObjectId, perchCommand )
end


function this.SetIgnoreNotice()
	
	local animalTypeList = {
		"TppWolf",
		"TppJackal",
		"TppZebra",
		"TppBear",
		"TppGoat",
		"TppNubian",
	}
	
	for i, animalType in ipairs( animalTypeList ) do
		local gameObjectId = { type = animalType, index = 0 }
		local command = {
			id			= "SetIgnoreNotice",
			isPlayer	= true
		}
		GameObject.SendCommand( gameObjectId, command )
	end
end




return this