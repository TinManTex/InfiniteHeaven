local s10086_radio = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




s10086_radio.radioList = {
	"f2000_rtrg8115",	
	"s0086_rtrg0010",	
	"s0086_rtrg0020",	
	"s0086_rtrg0030",	
	"s0086_rtrg0040",	
	{ "s0086_rtrg0050", playOnce = true, },	
	{ "s0086_rtrg0060", playOnce = true, },	
	{ "s0086_rtrg0070", playOnce = true, },	
	{ "s0086_rtrg0080", playOnce = true, },	
	{ "s0086_rtrg0090", playOnce = true, },	
	{ "s0086_rtrg0100", playOnce = true, },	
	{ "s0086_rtrg0110", playOnce = true, },	
	{ "s0086_rtrg0120", playOnce = true, },	
	{ "s0086_rtrg0130", playOnce = true, },	
	{ "s0086_rtrg0140", playOnce = true, },	
	{ "s0086_rtrg0150", playOnce = true, },	
	{ "s0086_rtrg0160", playOnce = true, },	
	{ "s0086_rtrg0170", playOnce = true, },	
	{ "s0086_rtrg0180", playOnce = true, },	
	{ "s0086_rtrg0190", playOnce = true, },	
	{ "s0086_rtrg0200", playOnce = true, },	
	{ "s0086_rtrg1010", playOnce = true, },	
	{ "s0086_rtrg1020", playOnce = true, },	
	{ "s0086_rtrg1030", playOnce = true, },	
	{ "s0086_rtrg1040", playOnce = true, },	
	{ "s0086_rtrg1050", playOnce = true, },	
	{ "s0086_rtrg1060", playOnce = true, },	
	{ "s0086_rtrg1065", playOnce = true, },	
	{ "s0086_rtrg1069", playOnce = true, },	
	{ "s0086_rtrg1070", playOnce = true, },	
	{ "s0086_rtrg1080", playOnce = true, },	
	{ "s0086_rtrg1090", playOnce = true, },	

	"s0086_rtrg0210",	
	"s0086_rtrg0220",	
	"s0086_rtrg0230",	
	{ "s0086_rtrg1120", playOnce = true, },	
	"s0086_rtrg1130",	
	"f1000_rtrg0600",	
	"f1000_rtrg1396",	
	"f1000_rtrg2040",	
	"f1000_rtrg2170",	
	"f2000_rtrg8115",	
	"s0086_rtrg0000",	

}





s10086_radio.optionalRadioList = {
	"Set_s0086_oprg0010",	
	"Set_s0086_oprg0020",	
	"Set_s0086_oprg0030",	
	"Set_s0086_oprg0040",	
	"Set_s0086_oprg0050",	
	"Set_s0086_oprg0070",	
	"Set_s0086_oprg0060",	
}





s10086_radio.intelRadioList = {
	type_enemy = "s0086_esrg0010",	
	hos_mis_0000 = "f1000_esrg0010",	
	hos_mis_0001 = "f1000_esrg0010",	
	hos_mis_0002 = "f1000_esrg0010",	
	hos_mis_0003 = "f1000_esrg0010",	
}








s10086_radio.commonRadioTable = {}
s10086_radio.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO
s10086_radio.commonRadioTable[ TppDefine.COMMON_RADIO.ENEMY_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO



s10086_radio.blackTelephoneDisplaySetting = {
	
	f6000_rtrg0120 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10086/mb_photo_10086_010_1.ftex", 0.6, "cast_viscount" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_03.ftex", 43.0 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_04.ftex", 49.0 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10086/mb_photo_10086_010_1.ftex", 0.6, "cast_viscount" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_03.ftex", 43.0 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_04.ftex", 49.4 }, 
		},
	},
	
	f6000_rtrg0130 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10086/mb_photo_10086_010_1.ftex", 0.6, "cast_viscount" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_03.ftex", 29.4 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_04.ftex", 35.6 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10086/mb_photo_10086_010_1.ftex", 0.6, "cast_viscount" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_03.ftex", 30.0 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10086_04.ftex", 36.5 },
		},
	},
}




s10086_radio.SetIntelRadio = function( gameObjectName, radioGroup )

	local intelRadioTable = { [ gameObjectName ] = radioGroup, }
	TppRadio.ChangeIntelRadio( intelRadioTable )

end




s10086_radio.ResetIntelRadio = function( gameObjectName )

	if gameObjectName == s10086_enemy.TARGET_NAME then	

		if s10086_sequence.IsRecognized( gameObjectName ) then	
			s10086_radio.SetIntelRadio( gameObjectName, "f1000_esrg0540" )
		else
			s10086_radio.SetIntelRadio( gameObjectName, "f1000_esrg0010" )
		end

	end

end






function s10086_radio.MissionStart()
	Fox.Log("#### s10086_radio.MissionStart ####")

	local radioGroup = s10086_radio.GetMissionStartRadio()

	if radioGroup then
		TppRadio.Play( radioGroup )
	end

end

function s10086_radio.GetMissionStartRadio()

	Fox.Log("#### s10086_radio.GetMissionStartRadio ####")

	local radioGroup
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_SearchTarget" and TppSequence.GetContinueCount() == 0 then	
		radioGroup = { "s0086_rtrg0010", }
	elseif TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	
		radioGroup = "f1000_rtrg1396"
	elseif s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME )	then	
		radioGroup = "s0086_rtrg0230"
	elseif TppEnemy.IsRecovered( s10086_enemy.INTERPRETER_NAME ) then	
		radioGroup = "s0086_rtrg0000"
	elseif s10086_sequence.IsRecognized( s10086_enemy.INTERPRETER_NAME ) then	
		radioGroup = "s0086_rtrg1140"
	else 	
		radioGroup = "s0086_rtrg0010"
	end

	return radioGroup

end


function s10086_radio.WarnHostageKilled()
	Fox.Log("#### s10086_radio.WarnHostageKilled ####")
	if not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then
		TppRadio.Play( "s0086_rtrg0020" )
	end
end


function s10086_radio.AboutInterrogation()
	Fox.Log("#### s10086_radio.AboutInterrogation ####")
	if not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then
		TppRadio.Play( { "s0086_rtrg0030", "s0086_rtrg0040", } )
	end
end


function s10086_radio.OnInterpreterMarked()

	Fox.Log("#### s10086_radio.InterpreterMarked ####")

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	

		

	end

end


function s10086_radio.OnInterpreterInterrogated()

	Fox.Log("#### s10086_radio.InterpreterInterrogated ####")

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	

		TppRadio.Play( "s0086_rtrg0060", { delayTime = "short" } )

	end

end


function s10086_radio.OnInterpreterRecovered()

	Fox.Log("#### s10086_radio.InterpreterRecovered ####")

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	

		local radioGroup
		if s10086_sequence.IsRecognized( s10086_enemy.INTERPRETER_NAME ) then
			radioGroup = "s0086_rtrg0070"
		else
			radioGroup = "s0086_rtrg0080"
		end
		TppRadio.Play( { radioGroup, "s0086_rtrg0090" }, { delayTime = "long" } )
		TppRadio.SetOptionalRadio( "Set_s0086_oprg0050" )
	elseif not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then
		TppRadio.Play( TppRadio.COMMON_RADIO_LIST[ TppDefine.COMMON_RADIO.ENEMY_RECOVERED ], { delayTime = "mid" } )
	else
		TppRadio.Play( "s0086_rtrg1060", { delayTime = "long", } )
	end

end


function s10086_radio.AfterInterpreterRecovered()

	if	s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) or	
		TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	
		return
	end

	Fox.Log("#### s10086_radio.AfterInterpreterRecovered ####")

	if TppClock.GetTimeOfDay() == "day" then	
		TppRadio.Play( "s0086_rtrg0100", { delayTime = "mid" } )
	else	
		TppRadio.Play( "s0086_rtrg0110", { delayTime = "mid" } )
	end
	TppRadio.Play( "f1000_rtrg1110", { delayTime = "mid", isEnqueue = true, } )
end


function s10086_radio.OnInterpreterSentToMB()
	
	Fox.Log("#### s10086_radio.OnInterpreterSentToMB ####")
	TppRadio.Play( { "s0086_rtrg0120", "s0086_rtrg0130", }, { delayTime = "mid" } )
end





function s10086_radio.OnTailingCanceled()

	if	s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) or	
		TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	
		return
	end

	Fox.Log("#### s10086_radio.TailingCanceled ####")
	TppRadio.Play( "s0086_rtrg0150", { delayTime = "mid" } )

end


function s10086_radio.OnKillingTarget()

	if	TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	
		return
	end

	Fox.Log("#### s10086_radio.KillingTarget ####")
	TppRadio.Play( "s0086_rtrg0160", { delayTime = "mid" } )

end


function s10086_radio.OnFakeTargetKilled()

	if	TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	
		return
	end

	Fox.Log("#### s10086_radio.FakeTargetKilled ####")
	TppRadio.Play( "s0086_rtrg0170", { delayTime = "mid" } )

end


function s10086_radio.OnInterpreterRecognized()

	Fox.Log("#### s10086_radio.InterpreterRecognized ####")

	s10086_radio.SetIntelRadio( "type_enemy", "Invalid" )

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	

		TppRadio.Play( "s0086_rtrg0180", { delayTime = "mid", isEnqueue = true, } )
		s10086_radio.SetIntelRadio( s10086_enemy.INTERPRETER_NAME, "s0086_esrg0100" )

	else
		TppRadio.Play( "s0086_rtrg1050", { delayTime = "mid", isEnqueue = true, } )
		s10086_radio.SetIntelRadio( s10086_enemy.INTERPRETER_NAME, nil )
	end

end


function s10086_radio.OnHostageMarked()

	Fox.Log("#### s10086_radio.HostageMarked ####")

	if not TppRadio.IsPlayed( "s0086_rtrg0190" ) then
		TppRadio.Play( "s0086_rtrg0190", { delayTime = "mid", } )
	else
		TppRadio.Play( "s0086_rtrg0200", { delayTime = "mid", } )
	end

end


function s10086_radio.OnFakeTargetRecognized( gameObjectId )

	Fox.Log( "s10086_radio.OnFakeTargetRecognized(): gameObjectId:" .. tostring( gameObjectId ) )

	local locatorName = s10086_enemy.GetFakeTargetName( gameObjectId )
	s10086_radio.SetIntelRadio( locatorName, "f1000_esrg1880" )

	local radioGroup
	if	s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) or	
		TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then	

		radioGroup = "s0086_rtrg0240"

	elseif TppRadio.IsPlayed( "s0086_rtrg1010" ) then
		radioGroup = "s0086_rtrg1010"
	else
		radioGroup = "f1000_rtrg2040"
	end
	TppRadio.Play( "s0086_rtrg1010", { delayTime = "mid", } )

end


function s10086_radio.OnFakeTargetRecovered( count )

	Fox.Log("#### s10086_radio.OnFakeTargetRecovered ####")

	if not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) then
		local radioGroups = {}
		radioGroups[ 1 ] = "s0086_rtrg1020"
		radioGroups[ 2 ] = "s0086_rtrg1030"
		radioGroups[ 3 ] = "s0086_rtrg1040"
		TppRadio.Play( radioGroups[ count ], { delayTime = "mid", } )

		
		if count == 3 then
			TppRadio.SetOptionalRadio( "Set_s0086_oprg0050" )
		end
	else
		TppRadio.Play( "f1000_rtrg0100", { delayTime = "mid", } )
	end

end


function s10086_radio.OnTargetRecognized()

	Fox.Log("#### s10086_radio.OnTargetRecognized ####")

	TppRadio.SetOptionalRadio( "Set_s0086_oprg0030" )	

	s10086_radio.SetIntelRadio( "type_enemy", "Invalid" )
	s10086_radio.SetIntelRadio( s10086_enemy.INTERPRETER_NAME, "Invalid" )

	TppRadio.ChangeIntelRadio{	
		[ s10086_enemy.TARGET_NAME ] = "s0086_esrg0130",	
		hos_mis_0001 = "s0086_esrg0080",	
		hos_mis_0002 = "s0086_esrg0080",	
		hos_mis_0003 = "s0086_esrg0080",	
	}

end




function s10086_radio.GetTargetRecognizedRadio()

	return "s0086_rtrg1065"

end


function s10086_radio.OnTargetRecovered()

	Fox.Log("#### s10086_radio.TargetRecovered ####")
	TppRadio.SetOptionalRadio( "Set_s0086_oprg0060" )

end

function s10086_radio.GetTargetRecoveredRadio()

	Fox.Log( "s10086_radio.GetTargetRecoveredRadio()" )
	if TppMotherBaseManagement.IsExistStaff{ skill= "TranslateAfrikaans", } or s10086_sequence.IsInterpreterDead() or TppEnemy.IsRecovered( s10086_enemy.INTERPRETER_NAME ) then
		return "s0086_rtrg1069"
	else
		return { "s0086_rtrg1069", "s0086_rtrg1070", }
	end

end


function s10086_radio.AfterInterpreterInterogated2()
	Fox.Log("#### s10086_radio.AfterInterpreterInterogated2 ####")
	TppRadio.Play( "s0086_rtrg1090", { delayTime = "long" } )
end


function s10086_radio.OnGameCleared1()
	Fox.Log("#### s10086_radio.OnGameCleared1 ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0120", { delayTime = "mid" } )
end


function s10086_radio.OnGameCleared2()
	Fox.Log("#### s10086_radio.OnGameCleared2 ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0130", { delayTime = "mid" } )
end




function s10086_radio.OnFakeTarget1TakenAway()

	Fox.Log( "s10086_radio.OnFakeTarget1TakenAway()" )

	if not s10086_sequence.IsRecognized( s10086_enemy.FAKE_TARGET1_NAME ) and
		not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then

		s10086_radio.SetIntelRadio( s10086_enemy.FAKE_TARGET1_NAME, "s0086_esrg0020" )

	else
		Fox.Log( "s10086_radio.OnFakeTarget1TakenAway(): ignore operation because FAKE_TARGET1 is recognized." )
	end

end




function s10086_radio.OnFakeTarget1FinishingMoving()

	Fox.Log( "s10086_radio.OnFakeTarget1FinishingMoving()" )

	if not s10086_sequence.IsRecognized( s10086_enemy.FAKE_TARGET1_NAME ) and
		not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then

		s10086_radio.SetIntelRadio( s10086_enemy.FAKE_TARGET1_NAME, "f1000_esrg0010" )

	else
		Fox.Log( "s10086_radio.OnFakeTarget1FinishingMoving(): ignore operation because FAKE_TARGET1 is recognized." )
	end

end




s10086_radio.OnFakeTargetInterrogationStarted = function( fakeTargetName )

	Fox.Log( "s10086_radio.OnFakeTargetInterrogationStarted(): fakeTargetName:" .. tostring( fakeTargetName ) )

	if not s10086_sequence.IsRecognized( fakeTargetName ) and
		not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then

		if fakeTargetName == s10086_enemy.FAKE_TARGET3_NAME then
			s10086_radio.SetIntelRadio( fakeTargetName, "s0086_esrg0040" )
		else
			s10086_radio.SetIntelRadio( fakeTargetName, "s0086_esrg0030" )
		end

	else
		Fox.Log( "s10086_radio.OnFakeTargetInterrogationStarted(): ignore operation because the hostage is recognized." )
	end

end




s10086_radio.OnFakeTargetInterrogationFinished = function( fakeTargetName )

	Fox.Log( "s10086_radio.OnFakeTargetInterrogationFinished(): fakeTargetName:" .. tostring( fakeTargetName ) )

	if not s10086_sequence.IsRecognized( fakeTargetName ) and
		not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) then

		s10086_radio.SetIntelRadio( fakeTargetName, "f1000_esrg0010" )

	else
		Fox.Log( "s10086_radio.OnFakeTargetInterrogationFinished(): ignore operation because the hostage is recognized." )
	end

end




s10086_radio.OnSearchTargetSequenceEnter = function()

	Fox.Log("#### s10086_radio.OnSearchTargetSequenceEnter ####")
	TppRadio.SetOptionalRadio( "Set_s0086_oprg0010" )

end





s10086_radio.OnEnemyRecovered = function()

	Fox.Log("#### s10086_radio.OnEnemyRecovered ####")
	TppRadio.Play( TppRadio.COMMON_RADIO_LIST[ TppDefine.COMMON_RADIO.ENEMY_RECOVERED ] )

end




s10086_radio.OnDelayAfterInterrogationFinished = function()

	Fox.Log( "s10086_radio.OnDelayAfterInterrogationFinished()" )
	TppRadio.Play( "s0086_rtrg1080" )

end




s10086_radio.OnIntelFileGotten = function()

	Fox.Log( "s10086_radio.OnIntelFileGotten()" )

	if TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) and
		( TppEnemy.IsRecovered( s10086_enemy.FAKE_TARGET1_NAME ) or TppEnemy.GetLifeStatus( s10086_enemy.FAKE_TARGET1_NAME ) == TppGameObject.NPC_LIFE_STATE_DEAD ) and
		( TppEnemy.IsRecovered( s10086_enemy.FAKE_TARGET2_NAME ) or TppEnemy.GetLifeStatus( s10086_enemy.FAKE_TARGET2_NAME ) == TppGameObject.NPC_LIFE_STATE_DEAD ) and
		( TppEnemy.IsRecovered( s10086_enemy.FAKE_TARGET3_NAME ) or TppEnemy.GetLifeStatus( s10086_enemy.FAKE_TARGET1_NAME ) == TppGameObject.NPC_LIFE_STATE_DEAD ) then
		

		TppRadio.Play( { "s0086_rtrg0210", "s0086_rtrg1130", } )

	elseif s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) then	
		TppRadio.Play( { "s0086_rtrg0210", "s0086_rtrg0220", } )


	else	
		TppRadio.Play( "s0086_rtrg0210" )
	end

end





s10086_radio.OnSealedToCancelFollowing = function()

	Fox.Log( "s10086_radio.OnSealedToCancelFollowing()" )

	TppRadio.Play( { "f1000_rtrg0600", } )

	if not s10086_enemy.IsEnemyNormal( s10086_enemy.INTERPRETER_NAME ) then
		TppRadio.SetOptionalRadio( "Set_s0086_oprg0020" )
	else
		TppRadio.SetOptionalRadio( "Set_s0086_oprg0050" )
	end

end




s10086_radio.OnInterrogation2Finished = function()

	Fox.Log( "s10086_radio.OnInterrogation2Finished()" )
	TppRadio.SetOptionalRadio( "Set_s0086_oprg0040" )

end




s10086_radio.OnPlayerHoldActiveWeapon = function()

	Fox.Log( "s10086_radio.OnPlayerHoldActiveWeapon()" )

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) and	
		Player.GetEquipTypeIdBySlot( vars.currentInventorySlot, vars.currentSupportWeaponIndex ) ~= TppEquip.EQP_TYPE_None then	

		TppRadio.Play( "s0086_rtrg1120", { delayTime = "short", isEnqueue = true, } )

	end

end




s10086_radio.OnEnglishSubtitlesShown = function()

	Fox.Log( "s10086_radio.OnEnglishSubtitlesShown()" )

	if	not s10086_sequence.IsRecognized( s10086_enemy.TARGET_NAME ) and	
		not TppEnemy.IsRecovered( s10086_enemy.TARGET_NAME ) and	
		not s10086_sequence.IsRecognized( s10086_enemy.INTERPRETER_NAME ) then	

		TppRadio.Play( "s0086_rtrg0050", { delayTime = "long", isEnqueue = true, } )

	end

end




return s10086_radio
