local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	{ "s0091_rtrg0010", playOnce = true },		
	{ "s0091_rtrg0020", playOnce = true },		

	{ "s0091_rtrg1010" },
	{ "s0091_rtrg1020" },
	{ "s0091_rtrg1030" },
	{ "s0091_rtrg1040", playOnce = true },		
	{ "s0091_rtrg1050", playOnce = true },
	{ "s0091_rtrg1060", playOnce = true },
	{ "s0091_rtrg1070", playOnce = true },
	{ "s0091_rtrg1080", playOnce = true },
	{ "s0091_rtrg1090", playOnce = true },
	
	"s0091_rtrg1100",
	{ "s0091_rtrg1105" },
	{ "s0091_rtrg1110", playOnce = true },
	{ "s0091_rtrg1120", playOnce = true },
	{ "s0091_rtrg1130", playOnce = true },		
	{ "s0091_rtrg1135" },		

	{ "s0091_rtrg1140", playOnce = true },	
	{ "s0091_rtrg1150" },		
	{ "s0091_rtrg2010" },
	{ "s0091_rtrg2020" },
	{ "s0091_rtrg2025" },
	{ "s0091_rtrg2030" },
	{ "s0091_rtrg2040" },
	{ "s0091_rtrg2050" },
	{ "s0091_rtrg3010" },
	{ "s0091_rtrg3020" },
	{ "s0091_rtrg4010" },

	
	"s0091_mprg1010",
	"s0091_mprg1030",
	"s0091_mprg1040",
	"s0091_mprg1050",

}




this.optionalRadioList = {
	"Set_s0091_oprg1000",		
	"Set_s0091_oprg2010",		
	"Set_s0091_oprg2020",		
	"Set_s0091_oprg2500",		
	"Set_s0091_oprg4000",		
}






this.intelRadioList = {
	
	sol_SwampWest_0002						=	"s0091_esrg1020",	
	sol_SwampWest_0003						=	"s0091_esrg1020",
	sol_SwampWest_0005						=	"s0091_esrg1020",

	
	hos_s10091_0000						=	"s0091_esrg1050",		
	hos_s10091_0001						=	"f1000_esrg0580",		
	hos_s10091_0002						=	"f1000_esrg0810",		
}


this.intelRadioList02 = {
	
	sol_SwampWest_0002						=	"s0091_esrg1030",		
	sol_SwampWest_0003						=	"s0091_esrg1030",

	
	hos_s10091_0000						=	"s0091_esrg1050",		
	hos_s10091_0001						=	"f1000_esrg0580",		
	hos_s10091_0002						=	"f1000_esrg0810",		
}


this.intelRadioList03 = {
	
	sol_SwampWest_0002						=	"s0091_esrg1010",	
	sol_SwampWest_0003						=	"s0091_esrg1010",

	
	hos_s10091_0000						=	"s0091_esrg1050",		
	hos_s10091_0001						=	"f1000_esrg0580",		
	hos_s10091_0002						=	"f1000_esrg0810",		
}


this.intelRadioList04 = {

	
	hos_s10091_0001						=	"f1000_esrg0580",		
	hos_s10091_0002						=	"f1000_esrg0810",		
}






this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.PLAYER_KILL_TARGET] = "f8000_gmov2500"			
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.TARGET_DEAD] = "f8000_gmov0110"				








this.ArrivedSwamp = function()
	Fox.Log("#### s10091_radio.ArrivedSwamp ####")
	TppRadio.Play( "s0091_rtrg0020", {isEnqueue = true } )
end


this.MissionStart = function()
	Fox.Log("#### s10091_radio.MissionStart ####")
	TppRadio.Play( "s0091_rtrg1010" )
end


this.MissionInfo1 = function()
	Fox.Log("#### s10091_radio.MissionInfo1 ####")
	TppRadio.Play( "s0091_rtrg1020" )
end


this.MissionInfo2 = function()
	Fox.Log("#### s10091_radio.MissionInfo2 ####")
	TppRadio.Play( "s0091_rtrg1030" )
end


this.EnterSwampForestFirst = function()
	Fox.Log("#### s10091_radio.EnterSwampForestFirst ####")
	TppRadio.Play( "s0091_rtrg1040" )
end


this.AfterEnterSwampForestFirst = function()
	Fox.Log("#### s10091_radio.AfterEnterSwampForestFirst ####")
	TppRadio.Play("s0091_rtrg1050",{ delayTime = "short"})
end


this.EnterIntelForestArea = function()
	Fox.Log("#### s10091_radio.EnterIntelForestArea ####")
	TppRadio.Play( "s0091_rtrg1060", { delayTime = "long", isEnqueue = true } )
end


this.GetTransceiver01 = function()
	Fox.Log("#### s10091_radio.GetTransceiver01 ####")
	TppRadio.Play( "s0091_rtrg1070", { delayTime = "mid", isEnqueue = true } )
end




this.FoundTarget01 = function()
	Fox.Log("#### s10091_radio.FoundTarget01 ####")
	TppRadio.Play( "s0091_rtrg1090", { delayTime = "mid" } )
end


this.FoundTarget02 = function()
	Fox.Log("#### s10091_radio.FoundTarget02 ####")
	
	TppRadio.Play( "s0091_rtrg1135", { delayTime = "mid" } )
end


this.ExecuteUnitOnMove01 = function()
	Fox.Log("#### s10091_radio.ExecuteUnitOnMove01 ####")
	TppRadio.Play( "s0091_rtrg1100", { delayTime = "long", isEnqueue = true } )
end


this.ExecuteUnitOnMove02 = function()
	Fox.Log("#### s10091_radio.ExecuteUnitOnMove02 ####")
	TppRadio.Play( "s0091_rtrg1105", { delayTime = "long", isEnqueue = true } )
end


this.ExecuteUnitRescued01 = function()
	Fox.Log("#### s10091_radio.ExecuteUnitRescued01 ####")
	TppRadio.Play( "s0091_rtrg1110", { delayTime = "long",	isEnqueue = true } )
end


this.ExecuteUnitRescued02 = function()
	Fox.Log("#### s10091_radio.ExecuteUnitRescued02 ####")
	TppRadio.Play( "s0091_rtrg1120", {isEnqueue = true } )
end



this.RescueOneAntherIsUnlocked = function()
	Fox.Log("#### s10091_radio.RescueOneAntherIsUnlocked ####")
	TppRadio.Play( "s0091_rtrg2010", { delayTime = "mid", isEnqueue = true } )
end



this.LocationOnTarget02First = function()
	Fox.Log("#### s10091_radio.LocationOnTarget02First ####")
	

	TppMission.UpdateObjective{
		radio = {
			radioGroups		= { "s0091_rtrg2020" },
			radioOptions	= { delayTime = "mid", isEnqueue = true },
		},
		objectives = { "default_area_swamp_Target02", "default_photo_CFABody" },
	}

end


this.LocationOnTarget02Second = function()
	Fox.Log("#### s10091_radio.LocationOnTarget02Second ####")
	

	TppMission.UpdateObjective{
		radio = {
			radioGroups		= { "s0091_rtrg2025" },
			radioOptions	= { delayTime = "mid", isEnqueue = true },
		},
		objectives = { "default_photo_CFABody" },
	}

end










this.AllTargetsRescued = function()
	Fox.Log("#### s10091_radio.AllTargetsRescued ####")
	TppRadio.Play( "s0091_rtrg4010", { delayTime = "short" } )
end



this.Continue01 = function()
	Fox.Log("#### s10091_radio.Continue01 ####")
	TppRadio.Play( "s0091_rtrg1150" )
end


this.Continue02 = function()
	Fox.Log("#### s10091_radio.Continue02 ####")
	TppRadio.Play( "s0091_rtrg2040" )
end


this.Continue03 = function()
	Fox.Log("#### s10091_radio.Continue03 ####")
	TppRadio.Play( "s0091_rtrg3020" )
end


this.Continue04 = function()
	Fox.Log("#### s10091_radio.Continue04 ####")
	TppRadio.Play( "s0091_rtrg2050" )
end


this.NextTarget02Position = function()
	Fox.Log("#### s10091_radio.NextTarget02Position ####")
	TppRadio.Play( { "s0091_rtrg2010", "s0091_rtrg2030", }, { delayTime = "mid", isEnqueue = true } )
end


this.NextTarget01Position = function()
	Fox.Log("#### s10091_radio.NextTarget01Position ####")
	TppRadio.Play( { "s0091_rtrg2010", "s0091_rtrg3010", }, { delayTime = "mid", isEnqueue = true } )
end


this.GetTransceiver03 = function()
	Fox.Log("#### s10091_radio.GetTransceiver03 ####")
	TppRadio.Play( { "s0091_rtrg1070", "s0091_rtrg1080", }, { delayTime = "mid", isEnqueue = true } )
end


this.ExecuteUnitRescued03 = function()
	Fox.Log("#### s10091_radio.ExecuteUnitRescued03 ####")
	TppRadio.Play( { "s0091_rtrg1110", "s0091_rtrg1120", }, {isEnqueue = true } )
end






this.InsertOptionalRadioEnterForest = function()
	if (svars.isTarget01Rescue	== false) and (svars.isTarget01Marked	== false)	then
		Fox.Log("###InsertOptionalRadiofor_Target01:s0091_oprg1060+s0091_oprg1070")
		this.InsertOptionalRadio( "s0091_oprg1070" )			
		this.InsertOptionalRadio( "s0091_oprg1060" )			

	else
		Fox.Log("###NoNeedInsertOptionalRadiofor_Target01 Cause he has been rescued or marked already")
	end
end


this.DeleteOptionalRadioEnterForest = function()
	Fox.Log("###Out of Forest/Target01Has been marked, DeleteOptionalRadiofor_Target01:s0091_oprg1060+s0091_oprg1070")
	this.DeleteOptionalRadio( "s0091_oprg1060" )			
	this.DeleteOptionalRadio( "s0091_oprg1070" )			
end


this.InsertOptionalRadioEnterSwamp = function()

	if (svars.isTarget01Rescue	== false) then	
		Fox.Log("###InsertOptionalRadiofor_Target02:s0091_oprg1030")
		this.InsertOptionalRadio( "s0091_oprg1030" )			

	else
		Fox.Log("###NoNeedInsertOptionalRadio：s0091_oprg1030")
	end


	if (svars.isTarget02Rescue	== false) and (svars.isTarget02Marked	== false)	then	
		Fox.Log("###InsertOptionalRadiofor_Target02:s0091_oprg1040")
		this.InsertOptionalRadio( "s0091_oprg1040" )			

	else
		Fox.Log("###NoNeedInsertOptionalRadiofor_Target02 Cause he has been rescued or marked already")
	end
end

this.DeleteOptionalRadioEnterSwamp = function()
	Fox.Log("###Out of Swamp/Target02Has been marked, DeleteOptionalRadiofor_Target02:s0091_oprg1030+s0091_oprg1040")
	this.DeleteOptionalRadio( "s0091_oprg1030" )
	this.DeleteOptionalRadio( "s0091_oprg1040" )
end



this.CheckDDogOptionalRadio = function()
	
	local canSortie = TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
	if canSortie == false then												
		Fox.Log("###NoD-Dog, DeleteOptionalRadio:f1000_oprg0115")
		this.DeleteOptionalRadio( "f1000_oprg0115" )						

	else																	
			Fox.Log("###HasBuddyD-Dog, DeleteOptionalRadio: f1000_oprg0105")
			this.DeleteOptionalRadio( "f1000_oprg0105" )						

		if	(vars.buddyType == BuddyType.DOG)		then
			Fox.Log("###But D-Dog is already in the Mission, DeleteOptionalRadio:f1000_oprg0115")
			this.DeleteOptionalRadio( "f1000_oprg0115" )						
		else
			Fox.Log("###But D-Dog hasn't been in the Mission Yet")
		end
	end
end


this.DeleteOptionalRadioOnTarget01 = function()
	Fox.Log("###Target01 Already been Marked  DeleteOptionalRadiofor_Target01:s0091_oprg1020")
	this.DeleteOptionalRadio( "s0091_oprg1020" )
end



this.InsertOptionalRadio = function(radioId)
	Fox.Log("InsertORadio()")
	if radioId == nil then
		Fox.Log("radioId is nil")
		return
	end
	Fox.Log("insert Radio. "..radioId )
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:RegisterRadioGroupToActiveRadioGroupSetInsert( radioId, 1 )
end



this.DeleteOptionalRadio = function(radioId)
	Fox.Log("###DeleteOptionalRadio()")
	if radioId == nil then
		Fox.Log("radioId is nil")
		return
	end
	Fox.Log("delete Radio. "..radioId )
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:UnregisterRadioGroupFromActiveRadioGroupSet( radioId )
end






return this
