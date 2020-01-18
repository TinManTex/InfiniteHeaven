local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local HOSTAGE_NAME = "hos_s10040_0000"




this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DEAD ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] = "s0040_rtrg4100"
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT ] = TppRadio.IGNORE_COMMON_RADIO



this.radioList = {
	{"s0040_rtrg1010",playOnce = true},	
	{"s0040_rtrg1020",playOnce = true},	
	{"s0040_rtrg1030",playOnce = true},	
	{"s0040_rtrg1040",playOnce = true},	

	{"s0040_rtrg1050",playOnce = true},	
	{"s0040_rtrg1060",playOnce = true},	
	{"s0040_rtrg1070",playOnce = true},	

	
	
	
	

	{"s0040_rtrg1130",playOnce = true},	
	{"s0040_rtrg1140",playOnce = true},	
	{"s0040_rtrg1150",playOnce = true},	
	{"s0040_rtrg2010",playOnce = true},	
	{"s0040_rtrg2020",playOnce = true},	
	{"s0040_rtrg2030",playOnce = true},	
	{"s0040_rtrg2040",playOnce = true},	
	{"s0040_rtrg2050",playOnce = true},	
	{"s0040_rtrg2070",playOnce = true},	
	{"s0040_rtrg2080",playOnce = true},	
	{"s0040_rtrg2090",playOnce = true},	
	{"s0040_rtrg2100",playOnce = true},	

	{"s0040_rtrg3010",playOnce = true},	
	{"s0040_rtrg3020",playOnce = true},	

	{"s0040_rtrg3030",playOnce = true},	
	{"s0040_rtrg3040",playOnce = true},	
	{"s0040_rtrg3050",playOnce = true},	
	{"s0040_rtrg3060",playOnce = true},	
	{"s0040_rtrg4010",playOnce = true},	
	{"s0040_rtrg4020",playOnce = false},	
	{"s0040_rtrg4030",playOnce = true},	

	{"s0040_rtrg4040",playOnce = true},	
	{"s0040_rtrg4050",playOnce = true},	
	{"s0040_rtrg4060",playOnce = true},	
	{"s0040_rtrg4070",playOnce = true},	
	{"s0040_rtrg4080",playOnce = true},	
	{"s0040_rtrg4090",playOnce = true},	
	{"s0040_rtrg4100",playOnce = false},	
	{"s0040_rtrg5010",playOnce = true},	
	{"s0040_rtrg5020",playOnce = true},	

	{"s0040_rtrg5030",playOnce = true},
	{"s0040_rtrg5040",playOnce = false},
	{"s0040_rtrg5050",playOnce = true},	
	"s0040_gmov3010",
	
	"s0040_mirg0010",	
	
	
	
	
}
this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10040_ARRIVAL_HONEY_BEE] = "s0040_gmov3010"





this.optionalRadioList = {
	"Set_s0040_oprg1000",	
	"Set_s0040_oprg2000",	
	"Set_s0040_oprg2500",	
	"Set_s0040_oprg3000",	
	"Set_s0040_oprg4000",	
	"Set_s0040_oprg5000",	
	nil
}













this.intelRadioList = {
	sol_fort_0000 ="s0040_esrg1010",
	sol_fort_0001 ="s0040_esrg1010",
	sol_fort_0002 ="s0040_esrg1010",
	sol_fort_0003 ="s0040_esrg1010",
	sol_fort_0004 ="s0040_esrg1010",
	sol_fort_0005 ="s0040_esrg1010",
	sol_fort_0006 ="s0040_esrg1010",
	sol_fort_0007 ="s0040_esrg1010",
	sol_fort_0008 ="s0040_esrg1010",
	rds_fort_ruin_0000 = "s0040_esrg1020",
	hos_s10040_0000 = "s0040_esrg2010",
					
					
	wmu_s10040_0000 = "s0040_esrg4020",
	wmu_s10040_0001 = "s0040_esrg4020",
	wmu_s10040_0002 = "s0040_esrg4020",
	wmu_s10040_0003 = "s0040_esrg4020",
	nil,
}

this.intelRadioZombieList = {
	sol_fort_0000 ="f1000_esrg1950",
	sol_fort_0001 ="f1000_esrg1950",
	sol_fort_0002 ="f1000_esrg1950",
	sol_fort_0003 ="f1000_esrg1950",
	sol_fort_0004 ="f1000_esrg1950",
	sol_fort_0005 ="f1000_esrg1950",
	sol_fort_0006 ="f1000_esrg1950",
	sol_fort_0007 ="f1000_esrg1950",
	sol_fort_0008 ="f1000_esrg1950",
	sol_fort_0009 ="f1000_esrg1950",
	sol_fort_0010 ="f1000_esrg1950",
	sol_fort_0011 ="f1000_esrg1950",
	sol_fort_0012 ="f1000_esrg1950",
	sol_fort_0013 ="f1000_esrg1950",
	sol_fort_0014 ="f1000_esrg1950",
	sol_fort_0015 ="f1000_esrg1950",
	sol_fort_0016 ="f1000_esrg1950",
	sol_fort_0017 ="f1000_esrg1950",
}

this.intelRadioNotZombieList = {
	sol_fort_0000 ="Invalid",
	sol_fort_0001 ="Invalid",
	sol_fort_0002 ="Invalid",
	sol_fort_0003 ="Invalid",
	sol_fort_0004 ="Invalid",
	sol_fort_0005 ="Invalid",
	sol_fort_0006 ="Invalid",
	sol_fort_0007 ="Invalid",
	sol_fort_0008 ="Invalid",
	sol_fort_0009 ="Invalid",
	sol_fort_0010 ="Invalid",
	sol_fort_0011 ="Invalid",
	sol_fort_0012 ="Invalid",
	sol_fort_0013 ="Invalid",
	sol_fort_0014 ="Invalid",
	sol_fort_0015 ="Invalid",
	sol_fort_0016 ="Invalid",
	sol_fort_0017 ="Invalid",
	rds_fort_ruin_0000 = "Invalid",

}



this.PlayRadioContinue = function()
	Fox.Log("flag check for continue radio")

	local radioId = nil

	if svars.isGetInfoHoneyBee then
		Fox.Log("not get honey bee.but player know that place")
		radioId = "s0040_rtrg3060"
	else
		Fox.Log("player dont know place.")
		if TppEnemy.GetLifeStatus( HOSTAGE_NAME ) == TppEnemy.LIFE_STATUS.DEAD then
			Fox.Log("ROA hostage is dead")
			radioId = "s0040_rtrg1140"
		else
			Fox.Log("ROA hostage is alive")
			radioId = "s0040_rtrg1130"
		end
	end

	return radioId

end

this.PlayMissionStart = function()
	Fox.Log(":: s10040 :: mission start ::")
	
	
	if svars.isGetMissile == true then
		this.PlayGetHoneyBee()
	elseif TppSequence.GetContinueCount() > 0 then
		Fox.Log("no play. because continue")
		local radio = this.PlayRadioContinue()
		
		TppRadio.Play(radio,{delayTime = "mid"})

		TppMission.UpdateObjective{
			objectives = { "default_area_fort" },
		}
	else

		TppMission.UpdateObjective{
			radio = {
				radioGroups = "s0040_rtrg1010",
			},
			objectives = { "default_area_fort" },
			options = { isMissionStart = true },
		}

	end

end


this.ORadioSet01 = function()
	Fox.Log("set opt 01")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg1000" )
end
this.ORadioSet20 = function()
	Fox.Log("set opt 20")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg2000" )
end
this.ORadioSet25 = function()
	Fox.Log("set opt 25")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg2500" )
end
this.ORadioSet30 = function()
	Fox.Log("set opt 30")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg3000" )
end
this.ORadioSet40 = function()
	Fox.Log("set opt 40")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg4000" )
end
this.ORadioSet50 = function()
	Fox.Log("set opt 50")
	TppRadio.SetOptionalRadio( "Set_s0040_oprg5000" )
end



this._InsertORadio = function(radioId, enable)
	if radioId == nil then
		Fox.Log("radioId is nil")
		return
	end
	Fox.Log("insert Radio. "..radioId )
	local radioDaemon = RadioDaemon:GetInstance()

	if enable == false then 
		radioDaemon:UnregisterRadioGroupFromActiveRadioGroupSet( radioId )
	else
		radioDaemon:RegisterRadioGroupToActiveRadioGroupSetInsert( radioId, 0 )
	end
end

this.InsertORadioBridge = function()
	Fox.Log("Insert Check : Bridge")
	if svars.isMarkHostage == false and 
	svars.isGetInfoHostage == false then

		this._InsertORadio("f1000_oprg0340")
	else
		Fox.Log("condition is not match")
	end
end

this.InsertORadioFort = function()
	Fox.Log("Insert Check : Fort")
	if svars.isMarkHostage == false and	
	svars.isGetInfoHoneyBee == false and
	svars.isGetInfoHostage == false and
	svars.isDeadHostage	== false then
		this._InsertORadio("s0040_oprg1060")
	end

	if svars.isGetInfoHoneyBee == false and	
	svars.isGetMissile == false and
	svars.isDeadHostage == true then
		this._InsertORadio("s0040_oprg1050")
	end

	if svars.isDeadHostage == true and svars.isGetMissile == false then
		local radioDaemon = RadioDaemon:GetInstance()
		radioDaemon:UnregisterRadioGroupFromActiveRadioGroupSet(  "s0040_oprg1040"  )
	end

end

this.InsertORadioAllHostage = function()
	Fox.Log("Insert Check : All Hostage")
	if svars.isGetInfoHostage == true and	
	svars.isMarkHostage == false then
		this._InsertORadio("s0040_oprg1070")
	end
end

this.InsertORadioEndAttackDemo = function()
	Fox.Log("Insert Check : End Attack Demo")
	if svars.isMarkHostage == true then	
		this._InsertORadio("s0040_oprg2020")
	end
end

this.InsertORadioAboutHostage = function()
	Fox.Log("Insert oprg2025")
	this._InsertORadio("s0040_oprg2025")
end
this.UnregisterORadioAboutHostage = function()
	this._InsertORadio("s0040_oprg2025", false)
end


this.SetIntelRadioZombie = function()
	Fox.Log("SetIntelRadioZombie")
	TppRadio.ChangeIntelRadio( this.intelRadioZombieList )
end

this.UnsetIntelRadioZombie = function()
	Fox.Log("UnsetIntelRadioZombie")
	TppRadio.ChangeIntelRadio( this.intelRadioNotZombieList )
end







this.PlayToDoFulton = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	if TppEnemy.GetStatus( "hos_s10040_0000" ) == TppGameObject.NPC_STATE_CARRIED then
		Fox.Log("carrying")
		TppRadio.Play("s0040_rtrg1050",{delayTime = "long"})
	else
		Fox.Log("not carry")
	end
end

this.PlayInFort = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg1060",{delayTime = "short"})

	this.InsertORadioFort()
end

this.PlayInBridge = function()
	Fox.Log(":: s10040_radio :: check flag. chenge radio by information of hostage ::")
	if svars.isGetInfoHostage then
		Fox.Log("have a information")
		TppRadio.Play("s0040_rtrg1020",{delayTime = "short"})
	else
		if TppEnemy.GetLifeStatus("hos_s10040_0000") == TppEnemy.LIFE_STATUS.DEAD then
			Fox.Log("dead hostage")
			TppRadio.Play("s0040_rtrg1040",{delayTime = "short"})
		else
			Fox.Log("no infomation")
			TppRadio.Play("s0040_rtrg1030",{delayTime = "short"})
		end
	end

	this.InsertORadioBridge()
end

this.PlayInCliffTown = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg1120",{delayTime = "short"})

	this.InsertORadioBridge()
end

this.PlayFoundHostage = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg2010",{delayTime = "short"})
	this.ORadioSet20()
end

this.PlayFoundHostageTaking = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg2020",{delayTime = "short"})
	this.ORadioSet20()
end

this.PlayHintOfRoom = function()
	Fox.Log(":: s10040 :: play hint of place if player do not know place ")
	if svars.isGetInfoHoneyBee then
		Fox.Log("no play radio, because player know place")
	else
		TppRadio.Play("s0040_rtrg1070",{delayTime = "short"})
	end
end

this.PlayGetHoneyBee = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg4020",{delayTime = "short",isEnqueue = true})
	this.ORadioSet50()
end

this.PlayRideOnVehicle = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	if Tpp.IsNotAlert() == true then
		TppRadio.Play("s0040_rtrg2030",{delayTime = "short"})
		this.InsertORadioEndAttackDemo()
	end
end

this.PlayGoToRescueHostage = function()
	if Tpp.IsNotAlert() == true then
		Fox.Log(":: s10040 :: radio.lua ::")
		TppRadio.Play("s0040_rtrg2040",{delayTime = "short"})
	end
end

this.PlayFindRoom = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg4010",{delayTime = "short"})
end

this.PlayStartedCombat = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg1150",{delayTime = "long"})

end


this.PlayLZwithHoneyBee = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg5030",{delayTime = "short"})
end
this.PlayLZwithoutHoneyBee = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg5040",{delayTime = "short"})
end



this.PlayBossEncounter = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg4040",{delayTime = "short"})
	this.ORadioSet40()
end

this.PlayBossEnd = function()
	Fox.Log(":: s10040 :: radio.lua :: PlayBossEnd")
	TppRadio.Play("s0040_rtrg5010",{delayTime = "long"})
	this.ORadioSet50()
end

this.PlayBossDown = function()
	Fox.Log(":: s10040 :: radio.lua :: PlayBossDown")
	TppRadio.Play("s0040_rtrg5020",{delayTime = "long"})
	this.ORadioSet50()
end

this.PlayUseHoneyBee = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play("s0040_rtrg4050",{delayTime = "short"})
	Fox.Log("Insert oprg4020")
	this._InsertORadio("s0040_oprg4010")

	this._InsertORadio("s0040_oprg4020")

end

this.UsedHoneyBee = function()
	Fox.Log("UsedHoneyBee")
	
	TppRadio.Play("s0040_rtrg4070",{delayTime = "mid"})
	
	if s10040_sequence.CheckGetHoneyBee() then
		TppRadio.Play("s0040_rtrg4080",{delayTime = "short",isEnqueue = true})
	end
end


this.PlayEnemyFoundHoneyBee = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppRadio.Play({"s0040_rtrg3030"},{delayTime = "mid"})
end
this.PlayEnemyNearHeli = function()
	Fox.Log(":: s10040 :: hurry ::")
	TppRadio.Play({"s0040_rtrg3040"},{delayTime = "mid"})
end




this.PlayDeadHostage = function(attackerId)
	Fox.Log(":: s10040 :: radio.lua ::")
	if attackerId == GameObject.GetGameObjectId("Player") then
		TppRadio.Play("s0040_rtrg2090",{delayTime = "mid"})
	else
		if s10040_sequence.CheckLookHostage() == true then
			TppRadio.Play("s0040_rtrg2100",{delayTime = "mid"})
		end
	end
	if svars.isGetInfoHoneyBee == false 
	and svars.isGetMissile == false then
		this.ORadioSet25()
	end
end

this.PlayFultonHost = function()
	Fox.Log(":: s10040 :: radio.lua ::")
	TppMission.UpdateObjective{
		radio = {
			radioGroups = "s0040_rtrg3020",
			radioOptions = {delayTime = "mid"},
		},
		objectives = { "marker_honey_bee",nil },
		options = { isMissionStart = true },
	}
	
end

this.PlayAfterRescue = function()
	Fox.Log(":: s10040 :: rtrg3010 ::")
	TppMission.UpdateObjective{
		radio = {
			radioGroups = "s0040_rtrg3010",
		},
		objectives = { "marker_honey_bee",nil },
	}
	
end

this.PlayHostageTakeStart = function()
	Fox.Log(":: s10040 :: start taking::")
	TppRadio.Play("s0040_rtrg2070",{delayTime = "short"})
end


this.PlayInfoHostage1 = function()
	Fox.Log(":: s10040 :: rescue normal hostage 1::")
	TppRadio.Play("s0040_rtrg1090",{delayTime = "short"})
end
this.PlayInfoHostage2 = function()
	Fox.Log(":: s10040 :: rescue normal hostage 2::")
	TppRadio.Play("s0040_rtrg1100",{delayTime = "short"})
end
this.PlayInfoHostage3 = function()
	Fox.Log(":: s10040 :: rescue normal hostage 3::")
	TppRadio.Play("s0040_rtrg1110",{delayTime = "short"})

	this.InsertORadioAllHostage()
end



this.PlayExitInnerZone = function()
	Fox.Log(":: s10040 :: ken gai ::")
	TppRadio.Play("s0040_rtrg5040",{delayTime = "short"})
end







this.PlayContinueEsc =function()
	Fox.Log(":: s10040 :: continue radio ::")
	TppRadio.Play("s0040_rtrg5050",{delayTime = "short"})

end



return this
