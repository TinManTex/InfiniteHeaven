









local this = {}

this.requires = {
	"/Assets/mgo/script/utils/GimmickIDs.lua",
	"/Assets/mgo/script/utils/RulesetCallbacks.lua",
	"/Assets/mgo/script/utils/SpawnHelpers.lua",
	"/Assets/mgo/script/ruleset/attack/Attack_Spawning.lua",
	"/Assets/mgo/script/ruleset/attack/Attack_Scoring.lua",
	"/Assets/mgo/script/ruleset/attack/Attack_Loadout.lua",
	"/Assets/mgo/script/ruleset/attack/Attack_Config.lua",
}

local DocsGimmick = {}

local FakeIntelGimmick = {}
local RealIntelGimmick = {}

local HackingTerminals = {}

local nukeGimmick = {}

this.POI_SYSTEM_ID = nil
this.attacker = 0
this.defender = 1
this.gameStartSeq = 0
this.winner = 0
this.round1Winner = -1
this.round = 1
this.teamPointsSolid = 0
this.teamPointsLiquid = 0
this.emptyTeam = -1
this.currentPhase = 1
this.maxMapMarkers = 7
this.phaseChangeFuncTable = {}
this.baseRoundTime = 360
this.phase1Time = 240
this.phase2Time = 60
this.phase3Time = 60
this.phase1SpentTime = 0
this.phase2SpentTime = 0
this.docScan = 0
this.maxDocs = 4
this.fultonPlayer = nil
this.doRoundEnd = false
this.announceDestruction = false


this.stunTracker = {}


this.tranqTracker = {}


this.charmTracker = {}

this.roundTimeTracker = {}

this.ModeNotification = nil

this.ScriptFlags = {
    [ 'Round1' ] = 1,
    [ 'Round2' ] = 2,
    [ 'Countdown1' ] = 3,
    [ 'Countdown2' ] = 4,
    [ 'AnnounceObjective' ] = 5,
	[ 'BGM_STOP_ALL' ] = 6,
    [ 'BGM_INTRO' ] = 7,
	[ 'BGM_ALERT' ] = 8,
    [ 'BGM_EVASION' ] = 9,
	[ 'BGM_CAUTION' ] = 10,
    [ 'BGM_SNEAK' ] = 11,
	[ 'BGM_OUTRO_WIN' ] = 12,
    [ 'BGM_OUTRO_LOSE' ] = 13,
    [ 'Phase1' ] = 14,		
    [ 'docProgress1' ] = 15,   
    [ 'docProgress2' ] = 16,
    [ 'docScanned1' ] = 17,		
    [ 'docScanned2' ] = 18,
    [ 'docScanned3' ] = 19,
    [ 'docScanned4' ] = 20,
    
    
    
    [ 'Phase2' ] = 21,		
    [ 'Phase2Delay' ] = 22,
    [ 'Phase3' ] = 23,		
    [ 'Phase3Delay' ] = 24,
    [ 'Phase4' ] = 25,		
    [ 'Real1' ] = 26,  
    [ 'Real2' ] = 27,
    [ 'Real3' ] = 28,
    [ 'Real4' ] = 29,
} 

this.GetDefaultNotificationMode = function()
	return Utils.ObjectiveMessage.MP_OBJ_MODE_AD;
end




this.notificationGroupIds =
{
	DEFAULT			= 0,
	MISSION_DD		= 1,
	MISSION_XOF		= 2,
}

this.notificationGroups = 
{
	
	{
		id					= this.notificationGroupIds.DEFAULT,
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
	},
	
	{
		id					= this.notificationGroupIds.MISSION_DD,
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
		teamIndex			= 0,
	},
	
	{
		id					= this.notificationGroupIds.MISSION_XOF,
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
		teamIndex			= 1,
	},
}



this.AddParam = function(data)
	data:AddDynamicParam("bool", "DisableDebugFly")
	data.DisableDebugFly = false
end




this.ClearParam = function(data)
	data.RemoveDynamicParam("DisableDebugFly")
end








this.rulesetState = nil
this.soundtrackPhase = nil

this.textureWaitTime = 0
this.textureWaitFrameTimeLast = 0




this.AddObjectiveBlip = function()	
	
	local Objective_Flag_Neutral = 0x10
	local Objective_Flag_Friendly = 0x20
	local Objective_Flag_Enemy = 0x40
	local typeFlag = 0x02
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
		
	local objectives = GameObject.SendCommand( this.POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = { "OBJECTIVE" },
			}
		}
	)
	if ( objectives.resultCount > 0) then		
		for i=1, objectives.resultCount do
			local objective =
			{ 
				keyPlaceIndex = i,
				enabled = true,
				position = 
				{
					objectives.results[i].posX,
					objectives.results[i].posY,
					objectives.results[i].posZ,					
				},
				name = "OUTPOST"
			}
			objective.networkTarget = "LOCAL"
			if localTeam == this.attacker then
				objective.flags = typeFlag + Objective_Flag_Enemy
			else
				objective.flags = typeFlag + Objective_Flag_Friendly
			end
			
			Mission.SetKeyPlace(objective)
		end		
	end	
end


this.AddControlBlip = function()	
	
	local Objective_Flag_Neutral = 0x10
	local Objective_Flag_Friendly = 0x20
	local Objective_Flag_Enemy = 0x40
	local typeFlagRealIntel = 0x01
	local typeFlagFakeIntel = 0x02 
	local objectives = nil
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	
	for i=1, this.maxDocs do	
	
		objectives = GameObject.SendCommand( this.POI_SYSTEM_ID,
			{
				id = "Search",
				criteria = 
				{
					type = TppPoi.POI_GENERIC,
					tags = { "CONTROL_POINT", "GENERIC_0" .. i },
				}
			}
		)
		local objective =
		{ 
			keyPlaceIndex = i,
			enabled = true,
			position = 
			{
				objectives.results[1].posX,
				objectives.results[1].posY,
				objectives.results[1].posZ,					
			},
			name = "OBJECTIVE"
		}		
		
		objective.networkTarget = "LOCAL"
		if localTeam == this.attacker then
			objective.flags = typeFlagRealIntel + Objective_Flag_Enemy
		else
			local iconType = typeFlagRealIntel
			for j = 1, #this.FakeIntelGimmick do
				if this.FakeIntelGimmick[j] == i then
					iconType = typeFlagFakeIntel
				end
			end
			objective.flags = iconType + Objective_Flag_Friendly
		end
	
		Mission.SetKeyPlace(objective)
	end
end

this.AddMissileBlip = function()	
	
	local Objective_Flag_Neutral = 0x10
	local Objective_Flag_Friendly = 0x20
	local Objective_Flag_Enemy = 0x40
	local typeFlag = 0x04
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
		
	local objectives = GameObject.SendCommand( this.POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = { "FORT" },
			}
		}
	)
	if ( objectives.resultCount > 0) then		
		for i=1, objectives.resultCount do
			local objective =
			{ 
				keyPlaceIndex = i,
				enabled = true,
				position = 
				{
					objectives.results[i].posX,
					objectives.results[i].posY,
					objectives.results[i].posZ,					
				},
				name = "OUTPOST"
			}
			objective.networkTarget = "LOCAL"
			if localTeam == this.attacker then
				objective.flags = typeFlag + Objective_Flag_Enemy
			else
				objective.flags = typeFlag + Objective_Flag_Friendly
			end
			Mission.SetKeyPlace(objective)
		end		
	end	
end

this.SyncPhase1Objectives = function (realIntelIndex1)
			
	local gimmickIndicies = { 1, 2, 3, 4 }
	
	table.insert(this.RealIntelGimmick, realIntelIndex1)
	
	
	if #this.RealIntelGimmick == this.maxDocs / 2 then
		for i = 1, #this.RealIntelGimmick do
			table.remove(gimmickIndicies, i)
		end
		
		for i = 1, #gimmickIndicies do
			table.insert(this.FakeIntelGimmick, gimmickIndicies[i])
		end
		this.AddControlBlip()
	end
end

this.RandomizePhase1Objectives = function()
	Fox.Log("RandomizePhase1Objectives")
	
	local gimmickIndicies = { 1, 2, 3, 4 }
	
	
	local real1index = math.random(#gimmickIndicies)
	local real1 = gimmickIndicies[real1index]
	table.remove(gimmickIndicies, real1index)
	local real2index = math.random(#gimmickIndicies)
	local real2 = gimmickIndicies[real2index]

	local ruleset = MpRulesetManager.GetActiveRuleset()
	local scriptFlags = ruleset:HostGetScriptFlags()
	if real1 == 1 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real1'] )
	elseif real1 == 2 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real2'] )
	elseif real1 == 3 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real3'] )
	elseif real1 == 4 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real4'] )
	end
	
	if real2 == 1 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real1'] )
	elseif real2 == 2 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real2'] )
	elseif real2 == 3 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real3'] )
	elseif real2 == 4 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Real4'] )
	end
	
	ruleset:HostSetScriptFlags( scriptFlags )
end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end




this.SetCurrentClock = function( hour, minute )
	Fox.Log( "SetCurrentClock is called across the network." )	
	WeatherManager.SetCurrentClock(hour, minute)	
	WeatherManager.PauseClock(true)		
	Fox.Log( "RefreshWeather is called across the network." )
end




this.Events = 
{

}








this.OnRulesetRoundStart = function( ... ) 
	this.stunTracker = {}
	this.tranqTracker = {}
	this.charmTracker = {}
	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundStart, unpack(arg)) 
	
	Utils.WeatherRequest(vars.locationCode, 1==vars.isNight, true)
	Utils.AscensionRoundStart()
	Utils.NotifyAllBuddies()
end


this.OnRulesetRoundEnd = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundEnd, unpack(arg)) end
this.OnRoundCountdownStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundCountdownStart, unpack(arg)) end
this.OnRoundStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundStart, unpack(arg)) end
this.OnPlayerDeath = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDeath, unpack(arg)) end
this.OnPlayerStunned = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerStunned, unpack(arg)) end
this.OnPlayerInterrogated = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerInterrogated, unpack(arg)) end
this.OnPlayerTagged = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerTagged, unpack(arg)) end

this.OnPlayerConnect = function( ... ) 
	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerConnect, unpack(arg)) 
	
	local rulesetData, ruleset, player = unpack(arg)
	
	local round1Time = 0;
	local round2Time = 0;
	local roundState = ruleset.currentState
	if roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" or
		roundState == "RULESET_STATE_ROUND_OVERTIME" or 
		roundState == "RULESET_STATE_ROUND_SUDDEN_DEATH" then
		
		Utils.ConnectAscensionPlayer(ruleset, player)
		
		local timeSpent = ruleset:GetTimeSpentInCurrentState()
		if timeSpent < 0 then
			timeSpent = 0
		end
		timeSpent = math.floor(timeSpent)
		
		if this.round == 1 then
			round1Time = timeSpent
		end
		if this.round == 2 then
			round2Time = timeSpent
		end
	end
	
	
	this.roundTimeTracker[player.sessionIndex] = { round1Time, round2Time }	
end

this.OnPlayerDisconnect = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDisconnect, unpack(arg)) end
this.OnPlayerRespawn = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerRespawn, unpack(arg)) end
this.OnPlayerFultonSave = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerFultonSave, unpack(arg)) end
this.OnPlayerSpawnChoiceExecute = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerSpawnChoiceExecute, unpack(arg)) end
this.SetupPlayerLoadout = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.SetupPlayerLoadout, unpack(arg)) end
this.OnEventSignal = function( stream )
	local triggeredId, eventCode, triggeringTeam, triggeringPlayerId = Utils.SerializeEvent( stream )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local triggeringPlayer = nil
	if triggeringPlayerId >= 0 then
		triggeringPlayer = ruleset:GetPlayerFromGameObjectId(triggeringPlayerId)
	else 
		triggeringPlayer = ruleset:GetPlayerFromTeamIndex(triggeringTeam, 0)
	end
	RulesetCallbacks.Multiplex( RulesetCallbacks.CallbackLists.OnEventSignal, triggeredId, eventCode, triggeringTeam, triggeringPlayer ) 
end

this.OnRulesetReset = function( ruleset )
	Fox.Log("Init starting")
	
	RulesetCallbacks.ClearCallbacks()

	
	local ret = true
				and RulesetCallbacks.SetupComponent("spawning", Attack_Spawning, this)
				and RulesetCallbacks.SetupComponent("scoring", Attack_Scoring, this)
				and RulesetCallbacks.SetupComponent("loadout", Attack_Loadout, this)

	Fox.Log( "Attack::OnRulesetReset " .. (ret and "successful" or "failed" ) )

	Attack_Config.SetReviveConfig(ruleset) 
	Attack_Config.SetCloakingConfig(ruleset)
	Attack_Config.SetSpawnConfig(ruleset)
	Utils.SetStaminaConfig(ruleset)

	this.textureWaitTime = 0
	this.textureWaitFrameTimeLast = 0
	
	
	Utils.StopWeatherClock()

	this.attacker = 0
	this.defender = 1
	this.gameStartSeq = 0
	this.winner = 0
	this.round1Winner = -1
	this.round = 1
	this.teamPointsSolid = 0
	this.teamPointsLiquid = 0
	this.emptyTeam = -1
	this.currentPhase = 1
	this.maxMapMarkers = 7
	this.baseRoundTime = vars.roundTimeLimit
	this.phase1Time = this.baseRoundTime
	this.docScan = 0
	this.maxDocs = 4 
	this.fultonPlayer = nil
	this.doRoundEnd = false
	this.announceDestruction = false

	this.ModeNotification = nil
	
	this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )
	
	this.initGimmicks()
	
	if Mgo.IsHost() then
		local scriptFlags = ruleset:HostGetScriptFlags()
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Round1'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	end
	
	return ret
end




this.OnSessionDisconnect = function( rulesetData, ruleset )
	Utils.HandleSessionDisconnect( rulesetData, ruleset )
end





this.IsReadyToInitialize = function()
	return Utils.AllRulesetBlocksAreLoaded()
end


this.InterrogateIntel = function( )

	if #this.FakeIntelGimmick > 0 then	
		local fakeScanIndex = math.random(#this.FakeIntelGimmick)
		local docGimmickIndex
		for i = 1, #this.DocsGimmick do
			if this.FakeIntelGimmick[fakeScanIndex] == this.DocsGimmick[i].mapID then
				docGimmickIndex = i		
			end
		end
		table.remove(this.FakeIntelGimmick, fakeScanIndex)
		this.FakeIntelRecover(docGimmickIndex, true)
	else
		this.StartPhase2()
	end

end

this.StartPhase2 = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	this.currentPhase = 2
	local scriptFlags = ruleset:HostGetScriptFlags()
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned2'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned3'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned4'] )
	scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase2'] )
	ruleset:HostSetScriptFlags( scriptFlags )	
	ruleset:ObjectiveNotification( Utils.Team.BOTH, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_INTEL, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_SCAN )
end

this.FakeIntelRecover = function(docGimmickIndex, wasInterrogated)

	local ruleset = MpRulesetManager.GetActiveRuleset()
	local fakeScanID = this.DocsGimmick[docGimmickIndex].mapID
	
	if wasInterrogated then
		ruleset:ObjectiveNotification( Utils.Team.BOTH, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_FAKE_INTERROGATE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_BUZZER )		
	else
		ruleset:ObjectiveNotification( Utils.Team.BOTH, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_FAKE_INTEL, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_BUZZER )		
	end
			
	local scriptFlags = ruleset:HostGetScriptFlags()
	if fakeScanID == 1 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['docScanned1'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	elseif fakeScanID == 2 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['docScanned2'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	elseif fakeScanID == 3 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['docScanned3'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	elseif fakeScanID == 4 then
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['docScanned4'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	end	
end

this.RecoverDoc = function( docGimmickIndex ) 

	
	
	local fakeScan = false
	local fakeScanIndex
	for i = 1, #this.FakeIntelGimmick do
		if this.FakeIntelGimmick[i] == this.DocsGimmick[docGimmickIndex].mapID then
			fakeScan = true	
			fakeScanIndex = i		
		end
	end

	this.DocsGimmick[docGimmickIndex].scanned = true
	
	if fakeScan == true then	
		table.remove(this.FakeIntelGimmick, fakeScanIndex)
		this.FakeIntelRecover(docGimmickIndex, false)		
	else
		this.StartPhase2()
	end	
end




this.MessageHandler = {
	OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3 )
		if not Mgo.IsHost() then
			return
		end
		local ruleset = MpRulesetManager.GetActiveRuleset()
		if ruleset.currentState ~= "RULESET_STATE_ROUND_REGULAR_PLAY" then	
			return
		end
		if Fox.StrCode32("SwitchGimmick") == messageId then
			if this.currentPhase == 1 then
				for i = 1, #this.DocsGimmick do
					if Fox.StrCode32( this.DocsGimmick[i].name ) == arg1 and Fox.PathFileNameCode32( this.DocsGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) and arg3 == 0 and this.DocsGimmick[i].scanned == false then
					
						this.RecoverDoc(i)
						
					end
				end
			end
			for i = 1, #HackingTerminals do
				if Fox.StrCode32( HackingTerminals[i].name ) == arg1 and Fox.PathFileNameCode32( HackingTerminals[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) and arg3 == 0 then
					this.currentPhase = 3
					local scriptFlags = ruleset:HostGetScriptFlags()
					scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase2'] )
					scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase3'] )
					ruleset:HostSetScriptFlags( scriptFlags )
				end
			end
		elseif Fox.StrCode32("SwitchScoreGimmick") == messageId then
			if this.currentPhase == 1 then
				for i = 1, #this.DocsGimmick do
					if Fox.StrCode32( this.DocsGimmick[i].name ) == arg1 and Fox.PathFileNameCode32( this.DocsGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
						local triggeringPlayer = ruleset:GetPlayerFromGameObjectId(arg3)
						ruleset:IncrementStatByPlayerIndex( triggeringPlayer.sessionIndex, MgoStat.STAT_DOCSCAN, 1 )
						ruleset:RulesetMessage( {player= triggeringPlayer.sessionIndex,  statId = "STAT_DOCSCAN", langTag = "mgo_ui_ruleticker_intel_scan" } )
					end
				end
			end
			for i = 1, #HackingTerminals do
				if Fox.StrCode32( HackingTerminals[i].name ) == arg1 and Fox.PathFileNameCode32( HackingTerminals[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
					local triggeringPlayer = ruleset:GetPlayerFromGameObjectId(arg3)
					ruleset:IncrementStatByPlayerIndex(  triggeringPlayer.sessionIndex, MgoStat.STAT_TERMINALHACK, 1 )
					ruleset:RulesetMessage( {player= triggeringPlayer.sessionIndex,  statId = "STAT_TERMINALHACK", langTag = "mgo_ui_ruleticker_terminal_hack" } )
				end
			end
		elseif Fox.StrCode32("AdjustFulton") == messageId then
			for i = 1, #nukeGimmick do
				if( Fox.StrCode32( nukeGimmick[i].name ) == arg2 ) then
					this.fultonPlayer = arg0
					ruleset:ObjectiveNotification( Utils.Team.BOTH, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_MFULTON, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD )
				end
			end
		elseif Fox.StrCode32("Fulton") == messageId then
			for i = 1, #nukeGimmick do
				if( Fox.StrCode32( nukeGimmick[i].name ) == arg1 ) and Fox.PathFileNameCode32( nukeGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
					this.currentPhase = 4
					local scriptFlags = ruleset:HostGetScriptFlags()
					scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase3'] )
					scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase4'] )
					ruleset:HostSetScriptFlags( scriptFlags )
					
					ruleset:IncrementStatByPlayerIndex( this.fultonPlayer, MgoStat.STAT_MISSILE_FULTON, 1 )
					ruleset:RulesetMessage( {player=this.fultonPlayer,  statId = "STAT_MISSILE_FULTON", langTag = "mgo_ui_ruleticker_missile_ful" } )
					ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_FULTON, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
					ruleset:ObjectiveNotification( this.defender, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_FULTON, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
				end
			end
		elseif Fox.StrCode32("FultonFailedGimmickMGO") == messageId then
			for i = 1, #nukeGimmick do
				if( Fox.StrCode32( nukeGimmick[i].name ) == arg1 ) and Fox.PathFileNameCode32( nukeGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
					ruleset:IncrementStatByPlayerIndex( arg3, MgoStat.STAT_FULTONSAVE, 1 )
					ruleset:RulesetMessage( {player=arg3,  statId = "STAT_FULTONSAVE", langTag = "mgo_ui_ruleticker_fulton_save" } )
				end
			end
		elseif Fox.StrCode32("BreakGimmick") == messageId then
			for i = 1, #nukeGimmick do
				if( Fox.StrCode32( nukeGimmick[i].name ) == arg1 ) and Fox.PathFileNameCode32( nukeGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
					this.currentPhase = 4
					local triggeringPlayer = ruleset:GetPlayerFromGameObjectId(arg3)			
					
					ruleset:IncrementStatByPlayerIndex( triggeringPlayer.sessionIndex, MgoStat.STAT_MISSILE_DESTROY, 1 )
					ruleset:RulesetMessage( {player=triggeringPlayer.sessionIndex,  statId = "STAT_MISSILE_DESTROY", langTag = "mgo_ui_ruleticker_missile_destroy" } )
					ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATTACK_WIN, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
					ruleset:ObjectiveNotification( this.defender, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATTACK_WIN, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
					
					local scriptFlags = ruleset:HostGetScriptFlags()
					scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase3'] )
					scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase4'] )
					ruleset:HostSetScriptFlags( scriptFlags )
					TppNetworkUtil.SyncedExecute( this._scriptPath, "nukeSmokeFXSync" )
				end
			end
		elseif Fox.StrCode32("DamageScoreGimmick") == messageId then
			for i = 1, #nukeGimmick do
				if( Fox.StrCode32( nukeGimmick[i].name ) == arg1 ) and Fox.PathFileNameCode32( nukeGimmick[i].dataset ) == Util.LuaNumberToUInt32( arg2 ) then
					ruleset:IncrementStatByPlayerIndex( arg3, MgoStat.STAT_MISSILE_DAMAGE, 1 )
					ruleset:RulesetMessage( {player=arg3,  statId = "STAT_MISSILE_DAMAGE", langTag = "mgo_ui_ruleticker_missile_damage" } )
				end
			end
		end
	end,
}


this.OnBuddyStateChanged = function( rulesetData, ruleset, created, buddy1, buddy2 )
	Utils.TryNotifyBuddyChange(ruleset, created, buddy1, buddy2)
end

this.BriefingTeamAssignCallback = function(rulesetData, ruleset)
	SpawnHelpers.BuddyAssignment(ruleset)
	Utils.AssignSpecialRoles( rulesetData, ruleset )
	SpawnHelpers.BriefingTeamAssignDone()
end


this.OnLocalPlayerTeamChanged = function(ruleset)
	GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
end




this.Init = function( rulesetData, ruleset )
	math.randomseed(os.time())
	this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )

	local ret = true
				and RulesetCallbacks.InitComponent("spawning", Attack_Spawning, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("scoring", Attack_Scoring, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("loadout", Attack_Loadout, rulesetData, ruleset)

	Fox.Log( "Attack::Init " .. (ret and "successful" or "failed" ) )

	local disableDebugFly = false

	if rulesetData.DisableDebugFly ~= nil then
		disableDebugFly = rulesetData.DisableDebugFly
	end

	ruleset:SetDebugFlyEnabled( not disableDebugFly )
	
	this.gameStartSeq = 0
	
	this.ModeNotification = Utils.ObjectiveMessage.MP_OBJ
	
	for i = 1, #this.notificationGroups do

		ruleset:RegisterNotificationGroup( this.notificationGroups[ i ] )

	end
	
	GameMessage.SetMessageHandler( this.MessageHandler, { "GameObject", "Player" } )
	this.docScan = 0

	Utils.SetupEffects(vars.locationCode, 1==vars.isNight)
	Utils.InitTutorial()

	return ret
end

this.switchOffGimmick = function(type, name, dataset)
	Gimmick.SetSwitchInteractability( type, name, dataset, false )
	Gimmick.SetIndicatorVisibility( type, name, dataset, false )
end

this.nukeSmokeFXSync = function()
	Util.SetInterval(1000, true, this._scriptPath, "playSmokeFX")
end

this.incDocScan = function()
	if this.currentPhase == 1 then
		this.docScan = this.docScan + 1
	end
end





this.GetSabotageState = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	local damageRatio = 0.0
	if( this.currentPhase == 3 ) then
		for i = 1, #nukeGimmick do
			local gimmick = nukeGimmick[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( gimmick.type, gimmick.name, gimmick.dataset )
			if doesExist then
				damageRatio = 1.0 - Gimmick.GetLifeRatio( gimmick.type, gimmick.name, gimmick.dataset )
			end
		end
	else
		damageRatio = 1.0
	end
	
	if Mgo.IsHost() and damageRatio >= 0.8 and damageRatio < 0.99 and this.announceDestruction == false then
		this.announceDestruction = true
		TppNetworkUtil.SyncedExecute( this._scriptPath, "announcerDestruction" )
	end
	
	return this.currentPhase, this.docScan, this.maxDocs, damageRatio
end

this.announcerDestruction = function()
	TppUiCommand.AnnounceLogViewLangId( "mgo_announce_SAB_missile_destroy" )
	TppDataUtility.CreateEffectFromId("nukeSparksFX")
	TppDataUtility.CreateEffectFromId("nukeSparksFX2")
end





this.IsGamePreLoad = function( rulesetData, ruleset )
	local textureLoadRatio = Mission.GetTextureLoadedRate()
	
	if ((textureLoadRatio >= Utils.TextureLoadWaitRatio) or (this.textureWaitTime <= 0)) then
		return false
	else
		return true
	end

	return false
end




this.CanGameStart = function( rulesetData, ruleset )
	if this.gameStartSeq == 0 then
		if this.textureWaitFrameTimeLast == 0 then
			this.textureWaitTime = Utils.TextureLoadWaitTimeout
			this.textureWaitFrameTimeLast = Time.GetRawElapsedTimeSinceStartUp()
		else
			local elapsedTime = Time.GetRawElapsedTimeSinceStartUp()
			this.textureWaitTime = this.textureWaitTime - (elapsedTime - this.textureWaitFrameTimeLast)
			this.textureWaitFrameTimeLast = elapsedTime
		end
	
		if( this.IsGamePreLoad( rulesetData, ruleset ) == false ) then
			this.gameStartSeq = 1
		end
	elseif this.gameStartSeq == 1 then
	
		Fox.Log("GAME START")	

		this.gameStartSeq = 2
		return true
	elseif this.gameStartSeq == 2 then
	
		return true
	end	

	return false
end


this.OnRegularTimeNearEnd = function(ruleset)
	Utils.OneMinuteLeft()
	
	if Mgo.IsHost() then
		ruleset:ObjectiveNotification( Utils.Team.SOLID, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_NOTIFY_NEAREND, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_CONTRACT_COMPLETE )
		ruleset:ObjectiveNotification( Utils.Team.LIQUID, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_NOTIFY_NEAREND, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_CONTRACT_COMPLETE )
	end
	this.OnRulesetStateChange(ruleset, "Caution")
	
	
	MgoUi.PreLoad( "MgoRoundEndUi" );
end


this.RoundEndEval = function( rulesetData, ruleset )
	local lastRound = false
	
	if this.round1Winner ~= -1 then
		lastRound = true
	end
	
	if this.emptyTeam == 0 then
		this.doRoundEnd = true
		this.winner = Utils.Team.LIQUID
		this.round = 2
		if lastRound == false then
			this.round1Winner = this.winner
		end
	elseif this.emptyTeam == 1 then
		this.doRoundEnd = true
		this.winner = Utils.Team.SOLID
		this.round = 2
		this.round1Winner = this.winner
		if lastRound == false then
			this.round1Winner = this.winner
		end
	end
	
	
	if this.currentPhase >= 4 then
	
		this.winner = this.attacker
		this.doRoundEnd = true
	elseif this.emptyTeam ~= -1 then 
		ruleset:ObjectiveNotification( this.winner, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
	elseif ruleset:IsRegularTimeOver() then

		ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_TS_ATTACK_LOSE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
		ruleset:ObjectiveNotification( this.defender, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_TS_ATTACK_LOSE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
		
		this.winner = this.defender
		this.doRoundEnd = true
	end
	
	
	if this.doRoundEnd then
		this.doRoundEnd = false
		this.teamPointsSolid = this.teamPointsSolid + ruleset:GetStatByTeamIndex( 0, MgoStat.STAT_TEAM_POINTS )
		this.teamPointsLiquid = this.teamPointsLiquid + ruleset:GetStatByTeamIndex( 1, MgoStat.STAT_TEAM_POINTS )
		local timeSpent = ruleset:GetTimeSpentInCurrentState()
		if timeSpent < 0 then
			timeSpent = 0
		end
		timeSpent = math.floor(timeSpent)
		TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", this.round, this.winner, timeSpent, this.currentPhase )
		Utils.WeatherRequest(vars.locationCode, 1==vars.isNight, false)
		
		
		local allPlayers = ruleset:GetAllActivePlayers().array
		
		for playerIndex = 1, #allPlayers do
			local player = allPlayers[ playerIndex ]		
			local localPlayerIndex = player.sessionIndex
			
			if player.teamIndex == this.winner then
				ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_MATCHES_WON, 1 )
			else
				ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_MATCHES_LOST, 1 )
			end
			
			ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_TOTAL_PLAYTIME, timeSpent )			
			
			if lastRound == false then
				this.roundTimeTracker[player.sessionIndex][1] = timeSpent - this.roundTimeTracker[player.sessionIndex][1]
			else
				this.roundTimeTracker[player.sessionIndex][2] = timeSpent - this.roundTimeTracker[player.sessionIndex][2]
			end
			
		end		
		
		
		if lastRound then
			local matchWinner = Utils.DetermineMatchWinner(ruleset, this.winner, this.round1Winner, this.teamPointsSolid, this.teamPointsLiquid)
			Utils.AwardGearPointsToAllPlayers(ruleset, matchWinner)	
			this.AwardMatchEndXPToAllPlayers(ruleset, matchWinner)	
			Utils.CheckAscensionPenalty(ruleset, matchWinner)
		end	
		
		if this.emptyTeam == 1 then 
			return true, this.winner, true
		else
			return true, this.winner
		end
	end
	
	return false, 0
end



this.AwardMatchEndXPToAllPlayers = function(ruleset, winner)		
		for playerIndex, team in pairs(SpawnHelpers.teamRoster) do
			local xpBonus;
			if team == winner then
				if this.roundTimeTracker[playerIndex] ~= nil then
					local totalPlayTime = (this.roundTimeTracker[playerIndex][1] + this.roundTimeTracker[playerIndex][2])
					xpBonus = (totalPlayTime / 60) * Utils.SAB_D_WinBonusPerMin
				end
			else
				if this.roundTimeTracker[playerIndex] ~= nil then
					local totalPlayTime = (this.roundTimeTracker[playerIndex][1] + this.roundTimeTracker[playerIndex][2])
					xpBonus = (totalPlayTime / 60) * Utils.SAB_D_LossBonusPerMin
				end
			end
			ruleset:IncrementStatByPlayerIndex( playerIndex, MgoStat.STAT_CALC_XP, xpBonus )
		end		
end

this.SetWinner = function( round, winner, time, phase )
	this.winner = winner
	if winner == Utils.Team.SOLID then
		TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_solid_win" )
	else
		TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_liquid_win" )
	end
	TppDataUtility.DestroyEffectFromId("forceFieldFXOFF")
	TppDataUtility.DestroyEffectFromId("nukeSmokeFX")
	TppDataUtility.DestroyEffectFromId("nukeSparksFX")
	TppDataUtility.DestroyEffectFromId("nukeSparksFX2")
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local objectiveComplete = false
	if scoreDefender == 0 then
		objectiveComplete = true
	end
	local localTeam = ruleset:GetLocalPlayerTeam()
	local isAttacker = false
	if localTeam == this.attacker then
		isAttacker = true
	end
	local phase1 = false
	local phase2 = false
	local phase3 = false
	if phase > 1 then
		phase1 = true
	end
	if phase > 2 then
		phase2 = true
	end
	if phase > 3 then
		phase3 = true
	end
	local RoundEndTableData = 
	{
		roundTime = time,
		roundWinnerId = winner,
		isLocalPlayerAttacking = isAttacker,
		hasObjective1 = phase1,
		hasObjective2 = phase2,
		hasObjective3 = phase3,
	}
	ruleset:SubmitRoundEndState( round, RoundEndTableData )
	
end

this.OnMatchEnd = function(rulesetData, ruleset)
	return Utils.DetermineMatchWinner(ruleset, this.winner, this.round1Winner, this.teamPointsSolid, this.teamPointsLiquid)
end

this.round2StateFlags = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local scriptFlags = ruleset:HostGetScriptFlags()
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Round1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Countdown1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['AnnounceObjective'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase2'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase2Delay'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase3'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase3Delay'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Phase4'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned2'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned3'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docScanned4'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docProgress1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['docProgress2'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Real1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Real2'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Real3'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Real4'] )
	scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Round2'] )
	ruleset:HostSetScriptFlags( scriptFlags )
	
	for i = 1, this.maxMapMarkers do
		local objective =
		{ 
			keyPlaceIndex = i,
			enabled = false,
			networkTarget = "ALL",
		}
		Mission.SetKeyPlace(objective)
	end
end

this.DespawnPlayers = function(ruleset)
	ruleset:DespawnAllPlayers()
	GameObject.SendCommand( {type="MgoActor"}, { id="ResetAll" } )
	ruleset:HideSpawnChoiceForAll()
	if this.round == 2 then
		this.callbackId = Util.SetInterval(0, true, this._scriptPath, "HostRestart")
	else
		this.round = 2
		this.round1Winner = this.winner

		SpawnHelpers.SwapSpawnsForEachTeam(this.POI_SYSTEM_ID)
		this.round2StateFlags()
		
		this.currentPhase = 1
		this.docScan = 0
		this.fultonPlayer = nil
		this.announceDestruction = false
	end
end

this.HostRestart = function()
	local padIndex = Pad.GetMainPadIndex()
	if Pad.GetButtonStatus( padIndex, fox.PAD_B ) then
		TppNetworkUtil.StopDebugSession()
		return false
	end
	return true
end

this.FreeplayReturn = function()
	GimmickIDs.removeTeamIcons()
	if not Mgo.IsHost() then
		vars.locationCode = TppDefine.LOCATION_ID.INIT
		vars.missionCode = TppDefine.SYS_MISSION_ID.INIT
		TppMission.Load( vars.locationCode )
		TppSimpleGameSequenceSystem.SetShowLoadScreen(1)
	else
		Util.SetInterval(8000, false, this._scriptPath, "FreeplayHostReturn")
	end
end

this.FreeplayHostReturn = function()
	vars.locationCode = TppDefine.LOCATION_ID.INIT
	vars.missionCode = TppDefine.SYS_MISSION_ID.INIT
	TppMission.Load( vars.locationCode )
	TppSimpleGameSequenceSystem.SetShowLoadScreen(1)
end




this.DoFrame = function( rulesetData, ruleset )
	Utils.DrawTutorial( ruleset, this.round )
end

this.OnRulesetStateChange = function( ruleset, newState )
	
	if Mgo.IsHost() then
		ruleset:GetTeamByIndex( this.attacker ).isAsymmetricAttacker = true
		ruleset:GetTeamByIndex( this.defender ).isAsymmetricAttacker = false
		if newState == TppMpBaseRuleset.RULESET_STATE_END_OF_MATCH_FLOW then
			this.DespawnPlayers(ruleset)
		end
	end
	
	
	local prevSoundtrackPhase = this.soundtrackPhase
	
	if newState == TppMpBaseRuleset.RULESET_STATE_INACTIVE then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_GAME_START then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_ROUND_COUNTDOWN then
		this.soundtrackPhase = 'BGM_INTRO'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_ROUND_REGULAR_PLAY then
		this.soundtrackPhase = 'BGM_SNEAK'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_ROUND_OVERTIME then
		this.soundtrackPhase = 'BGM_ALERT'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_ROUND_SUDDEN_DEATH then
		this.soundtrackPhase = 'BGM_ALERT'
	elseif newState == "AlertPhase" then
		this.soundtrackPhase = 'BGM_ALERT'
	elseif newState == "Caution" then
		this.soundtrackPhase = 'BGM_CAUTION'
	elseif newState == TppMpBaseRuleset.RULESET_STATE_ROUND_END then
		if ruleset:GetLocalPlayerTeam() == this.winner then
			this.soundtrackPhase = 'BGM_OUTRO_WIN'
		else
			this.soundtrackPhase = 'BGM_OUTRO_LOSE'
		end
	elseif newState == TppMpBaseRuleset.RULESET_STATE_GAME_END then
		if ruleset:GetLocalPlayerTeam() == this.winner then
			this.soundtrackPhase = 'BGM_OUTRO_WIN'
		else
			this.soundtrackPhase = 'BGM_OUTRO_LOSE'
		end
	end
	
	
	if prevSoundtrackPhase ~= this.soundtrackPhase then
		if this.soundtrackPhase == "BGM_STOP_ALL" then
			MGOSoundtrack2.Stop()
		elseif this.soundtrackPhase == "BGM_INTRO" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_START_JINGLE )
		elseif this.soundtrackPhase == "BGM_ALERT" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_ALERT )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_EVASION" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_EVASION )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_CAUTION" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_CAUTION )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_SNEAK" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_SNEAK )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_OUTRO_WIN" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_WIN_JINGLE )
		elseif this.soundtrackPhase == "BGM_OUTRO_LOSE" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_LOSE_JINGLE )
		end
	end
end

this.OnPlayerSpawn = function(rulesetData, ruleset, localPlayerSessionId)
	WeatherManager.PauseClock(true)
end

this.OnPlayerSpawnChoiceExecute = function(rulesetData, ruleset, player, isBuddySpawn)
	
end

this.docProgress = function( idx )
	
	local docFound = false
	for i = 1, #this.DocsGimmick do
		if this.DocsGimmick[i].mapID == idx then
			local doc = this.DocsGimmick[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( doc.type, doc.name, doc.dataset )
			if doesExist then
				doc.scanned = true
				docFound = true
				Gimmick.SetIndicatorVisibility( doc.type, doc.name, doc.dataset, false)
				Gimmick.SetSwitchInteractability( doc.type, doc.name, doc.dataset, false)
				
				local objective =
				{ 
					keyPlaceIndex = doc.mapID,
					enabled = false,
					networkTarget = "LOCAL",
				}
				Mission.SetKeyPlace(objective)
			end
			TppSoundDaemon.PostEvent( "sfx_UI_Document_Scan_Complete" )
		end	
	end
end

this.phase1Enter = function()	
	this.currentPhase = 1
	this.baseRoundTime = vars.roundTimeLimit 
	this.phase1Time = this.baseRoundTime
	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	if Mgo.IsHost() then
		ruleset:SetTimeLimitInCurrentState( this.phase1Time )
	end
	
	
	for i = 1, #this.DocsGimmick do
		local doc = this.DocsGimmick[i]                                           
		local doesExist = Gimmick.DoesPermanentGimmickExist( doc.type, doc.name, doc.dataset )
		if doesExist then
			Gimmick.SetIndicatorVisibility( doc.type, doc.name, doc.dataset, true)
			Gimmick.SetSwitchInteractability( doc.type, doc.name, doc.dataset, true)
			this.DocsGimmick[i].scanned = false
		end
	end
	
	
	
	for i = 1, #HackingTerminals do
		local terminal = HackingTerminals[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( terminal.type, terminal.name, terminal.dataset )
		if doesExist then
			Gimmick.SetSwitchInteractability( terminal.type, terminal.name, terminal.dataset, false)
			Gimmick.SetIndicatorVisibility( terminal.type, terminal.name, terminal.dataset, false)
		end
	end
	for i = 1, #nukeGimmick do
		local nuke = nukeGimmick[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( nuke.type, nuke.name, nuke.dataset )
		if doesExist then
			Gimmick.SetFultonability( nuke.type, nuke.name, nuke.dataset, false )
			Gimmick.SetIndicatorVisibility( nuke.type, nuke.name, nuke.dataset, false )
		end
	end
end

this.phase2Enter = function()
	this.currentPhase = 2
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	for i = 1, this.maxMapMarkers do
		local objective =
		{ 
			keyPlaceIndex = i,
			enabled = false,
			networkTarget = "LOCAL",
		}
		Mission.SetKeyPlace(objective)
	end
	if localTeam == this.defender then
		TppUiCommand.RequestMbSoundControllerVoice("VOICE_DEFEND_TERMINAL")
		this.AddObjectiveBlip()
	end
	if Mgo.IsHost() then
		ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_P2DELAY, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE2 )
		ruleset:ObjectiveNotification( this.defender, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_DEF_P2, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE2 )
		
		ruleset:AddTimeRemainingInCurrentState( this.phase2Time )
		
		Util.SetInterval(15000, false, this._scriptPath, "phase2delaytime")
	end
	this.OnRulesetStateChange( ruleset, "Caution" )
	
	for i = 1, #this.DocsGimmick do
		local doc = this.DocsGimmick[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( doc.type, doc.name, doc.dataset )
		if doesExist then
			Gimmick.SetSwitchInteractability( doc.type, doc.name, doc.dataset, false)
			Gimmick.SetIndicatorVisibility( doc.type, doc.name, doc.dataset, false)
		end
	end
	for i = 1, #nukeGimmick do
		local nuke = nukeGimmick[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( nuke.type, nuke.name, nuke.dataset )
		if doesExist then
			Gimmick.SetFultonability( nuke.type, nuke.name, nuke.dataset, false )
			Gimmick.SetIndicatorVisibility( nuke.type, nuke.name, nuke.dataset, false )
		end
	end

	if localTeam == this.defender then
		for i = 1, #HackingTerminals do
			local terminal = HackingTerminals[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( terminal.type, terminal.name, terminal.dataset )
			if doesExist then
				Gimmick.SetSwitchInteractability ( terminal.type, terminal.name, terminal.dataset, true)
				Gimmick.SetIndicatorVisibility ( terminal.type, terminal.name, terminal.dataset, true)
			end
		end
	end
end

this.phase2delaytime = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_P2, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE2 )
	local scriptFlags = ruleset:HostGetScriptFlags()
	scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase2Delay'] )
	ruleset:HostSetScriptFlags( scriptFlags )
end

this.phase2DelayEnter = function()
	this.currentPhase = 2
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	if localTeam == this.attacker then
		this.AddObjectiveBlip()
		TppUiCommand.RequestMbSoundControllerVoice("VOICE_ACCESS_TERMINAL")
		for i = 1, #HackingTerminals do
			local terminal = HackingTerminals[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( terminal.type, terminal.name, terminal.dataset )
			if doesExist then
				Gimmick.SetSwitchInteractability ( terminal.type, terminal.name, terminal.dataset, true)
				Gimmick.SetIndicatorVisibility ( terminal.type, terminal.name, terminal.dataset, true)
			end
		end
	end
end

this.phase3Enter = function()
	this.currentPhase = 3
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	for i = 1, this.maxMapMarkers do
		local objective =
		{ 
			keyPlaceIndex = i,
			enabled = false,
			networkTarget = "LOCAL",
		}
		Mission.SetKeyPlace(objective)
	end
	if localTeam == this.defender then
		TppUiCommand.RequestMbSoundControllerVoice("VOICE_PROTECT_MISSILE")
		this.AddMissileBlip()
	end
	
	if Mgo.IsHost() then
		ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_P3DELAY, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE3 )
		ruleset:ObjectiveNotification( this.defender, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_DEF_P3, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE3 )
		
		ruleset:AddTimeRemainingInCurrentState( this.phase3Time )
		
		Util.SetInterval(15000, false, this._scriptPath, "phase3delaytime")
	end
	this.OnRulesetStateChange( ruleset, "AlertPhase" )
	
	for i = 1, #this.DocsGimmick do
		local doc = this.DocsGimmick[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( doc.type, doc.name, doc.dataset )
		if doesExist then
			Gimmick.SetSwitchInteractability( doc.type, doc.name, doc.dataset, false)
			Gimmick.SetIndicatorVisibility( doc.type, doc.name, doc.dataset, false)
		end
	end
	for i = 1, #HackingTerminals do
		local terminal = HackingTerminals[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( terminal.type, terminal.name, terminal.dataset )
		if doesExist then
			Gimmick.SetSwitchInteractability( terminal.type, terminal.name, terminal.dataset, false)
			Gimmick.SetIndicatorVisibility( terminal.type, terminal.name, terminal.dataset, false)
		end
	end
	if localTeam == this.defender then
		for i = 1, #nukeGimmick do
			local nuke = nukeGimmick[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( nuke.type, nuke.name, nuke.dataset )
			if doesExist then
				Gimmick.SetFultonability( nuke.type, nuke.name, nuke.dataset, true )
				Gimmick.SetIndicatorVisibility( nuke.type, nuke.name, nuke.dataset, true )
			end
		end
	end
end

this.phase3delaytime = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	ruleset:ObjectiveNotification( this.attacker, this.ModeNotification, Utils.ObjectiveMessage.MP_OBJ_ATK_ATK_P3, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_SAB_PHASE3 )
	local scriptFlags = ruleset:HostGetScriptFlags()
	scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Phase3Delay'] )
	ruleset:HostSetScriptFlags( scriptFlags )
end


this.phase3DelayEnter = function()
	this.currentPhase = 3
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	local forceField = StaticModel.GetByName("mgo_nuke001_gim_n0000|force_field")
	forceField.isVisible = false
	forceField.isGeomActive = false
	TppDataUtility.SetVisibleEffectFromId("forceFieldFX", false)
	TppDataUtility.CreateEffectFromId("forceFieldFXOFF")
	if localTeam == this.attacker then
		this.AddMissileBlip()
		TppUiCommand.RequestMbSoundControllerVoice("VOICE_DESTROY_MISSILE")
		
		for i = 1, #nukeGimmick do
			local nuke = nukeGimmick[i]
			local doesExist = Gimmick.DoesPermanentGimmickExist( nuke.type, nuke.name, nuke.dataset )
			if doesExist then
				Gimmick.SetFultonability( nuke.type, nuke.name, nuke.dataset, true )
				Gimmick.SetIndicatorVisibility( nuke.type, nuke.name, nuke.dataset, true )
			end
		end
	end
end

this.phase4Enter = function()
	this.currentPhase = 4
	for i = 1, #nukeGimmick do
		local nuke = nukeGimmick[i]
		local doesExist = Gimmick.DoesPermanentGimmickExist( nuke.type, nuke.name, nuke.dataset )
		if doesExist then
			Gimmick.SetIndicatorVisibility( nuke.type, nuke.name, nuke.dataset, false)
		end
	end
end

this.playSmokeFX = function()
	TppDataUtility.CreateEffectFromId("nukeSmokeFX")
end

this.OnGimmickDestroyed = function( ruleset, destroyedGimmickType, gimmickNameId, gimmickPathId, attackerPlayer )
end





this.OnScriptFlagChanged = function( flagIndex, isOn ) 
    
    local flagString = nil
    for k,v in pairs(this.ScriptFlags) do
        if flagIndex == v  then flagString = k end
    end

    
    if( isOn ) then
        if flagString == "Round1" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			this.round = 1
			this.attacker = Utils.Team.SOLID
			this.defender = Utils.Team.LIQUID
			ruleset:GetTeamByIndex( this.attacker ).isAsymmetricAttacker = true
			ruleset:GetTeamByIndex( this.defender ).isAsymmetricAttacker = false
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
			
			this.FakeIntelGimmick = {}
			this.RealIntelGimmick = {}
			if Mgo.IsHost() then
				this.RandomizePhase1Objectives()
			end
			
		elseif flagString == "Round2" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			this.round = 2
			this.attacker = Utils.Team.LIQUID
			this.defender = Utils.Team.SOLID
			ruleset:GetTeamByIndex( this.attacker ).isAsymmetricAttacker = true
			ruleset:GetTeamByIndex( this.defender ).isAsymmetricAttacker = false
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
			
			this.FakeIntelGimmick = {}
			this.RealIntelGimmick = {}
			if Mgo.IsHost() then
				this.RandomizePhase1Objectives()
			end
			
			local forceField = StaticModel.GetByName("mgo_nuke001_gim_n0000|force_field")
			forceField.isVisible = true
			forceField.isGeomActive = true
			TppDataUtility.SetVisibleEffectFromId("forceFieldFX", true)
			TppDataUtility.DestroyEffectFromId("forceFieldFXOFF")
			TppDataUtility.DestroyEffectFromId("nukeSmokeFX")
			TppDataUtility.DestroyEffectFromId("nukeSparksFX")
			TppDataUtility.DestroyEffectFromId("nukeSparksFX2")
			this.initGimmicks()
			TppBullet.ClearBulletMark()
		elseif flagString == "Countdown1" or flagString == "Countdown2"  then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			
		elseif flagString == "Phase1" then
			this.docScan = 0
			this.phase1Enter()
		elseif flagString == "Phase2" then
			this.phase2Enter()
		elseif flagString == "Phase2Delay" then
			this.phase2DelayEnter()
		elseif flagString == "Phase3" then
			this.phase3Enter()
		elseif flagString == "Phase3Delay" then
			this.phase3DelayEnter()
		elseif flagString == "Phase4" then
			this.phase4Enter()
		elseif flagString == "AnnounceObjective" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			local localTeam = ruleset:GetLocalPlayerTeam()
			if localTeam == this.attacker then
				
				TppUiCommand.RequestMbSoundControllerVoice("VOICE_SECURE_INTEL")
			else
				
				TppUiCommand.RequestMbSoundControllerVoice("VOICE_DEFEND_INTEL")
			end
		elseif flagString == "docProgress1" then
			this.docScan = 1
		elseif flagString == "docProgress2" then
			this.docScan = 2
		elseif flagString == "docScanned1" then
			this.docProgress( 1 )
		elseif flagString == "docScanned2" then
			this.docProgress( 2 )
		elseif flagString == "docScanned3" then
			this.docProgress( 3 )
		elseif flagString == "docScanned4" then
			this.docProgress( 4 )
		elseif flagString == "Real1" then
			this.SyncPhase1Objectives(1)
		elseif flagString == "Real2" then
			this.SyncPhase1Objectives(2)
		elseif flagString == "Real3" then
			this.SyncPhase1Objectives(3)
		elseif flagString == "Real4" then
			this.SyncPhase1Objectives(4)
		end
    else
        Fox.Log( "Host has Cleared flag:  flagIndex " .. flagIndex .. ", flagString " .. flagString )
    end
end





this.DBEUG_LookupObjectiveMessage = function( ruleset, messageId )
	return Utils.DBEUG_LookupObjectiveMessage ( ruleset, messageId )
end

this.initGimmicks = function()
	this.DocsGimmick = {
		[1] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs.fox2",
						mapID = 1,
						scanned = false,
		},
		[2] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs.fox2",
						mapID = 2,
						scanned = false,
		},
		[3] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs.fox2",
						mapID = 3,
						scanned = false,
		},
		[4] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs.fox2",
						mapID = 4,
						scanned = false,
		},
		[5] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs2.fox2",
						mapID = 1,
						scanned = false,
		},
		[6] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs2.fox2",
						mapID = 2,
						scanned = false,
		},
		[7] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs2.fox2",
						mapID = 3,
						scanned = false,
		},
		[8] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/docs2.fox2",
						mapID = 4,
						scanned = false,
		},
		[9] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs.fox2",
						mapID = 1,
						scanned = false,
		},
		[10] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs.fox2",
						mapID = 2,
						scanned = false,
		},
		[11] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs.fox2",
						mapID = 3,
						scanned = false,
		},	
		[12] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs.fox2",
						mapID = 4,
						scanned = false,
		},
		[13] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs2.fox2",
						mapID = 1,
						scanned = false,
		},
		[14] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs2.fox2",
						mapID = 2,
						scanned = false,
		},
		[15] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs2.fox2",
						mapID = 3,
						scanned = false,
		},	
		[16] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/docs2.fox2",
						mapID = 4,
						scanned = false,
		},
		[17] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs.fox2",
						mapID = 1,
						scanned = false,
		},
		[18] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs.fox2",
						mapID = 2,
						scanned = false,
		},
		[19] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs.fox2",
						mapID = 3,
						scanned = false,
		},
		[20] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs.fox2",
						mapID = 4,
						scanned = false,
		},
		[21] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs2.fox2",
						mapID = 1,
						scanned = false,
		},
		[22] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs2.fox2",
						mapID = 2,
						scanned = false,
		},
		[23] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs2.fox2",
						mapID = 3,
						scanned = false,
		},
		[24] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/docs2.fox2",
						mapID = 4,
						scanned = false,
		},
		[25] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs.fox2",
						mapID = 1,
						scanned = false,
		},
		[26] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs.fox2",
						mapID = 2,
						scanned = false,
		},
		[27] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs.fox2",
						mapID = 3,
						scanned = false,
		},	
		[28] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs.fox2",
						mapID = 4,
						scanned = false,
		},	
		[29] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs2.fox2",
						mapID = 1,
						scanned = false,
		},
		[30] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs2.fox2",
						mapID = 2,
						scanned = false,
		},
		[31] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs2.fox2",
						mapID = 3,
						scanned = false,
		},
		[32] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs2.fox2",
						mapID = 4,
						scanned = false,
		},
		[33] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs.fox2",
						mapID = 1,
						scanned = false,
		},
		[34] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs.fox2",
						mapID = 2,
						scanned = false,
		},
		[35] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs.fox2",
						mapID = 3,
						scanned = false,
		},
		[36] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs.fox2",
						mapID = 4,
						scanned = false,
		},
		[37] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs2.fox2",
						mapID = 1,
						scanned = false,
		},
		[38] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs2.fox2",
						mapID = 2,
						scanned = false,
		},
		[39] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs2.fox2",
						mapID = 3,
						scanned = false,
		},
		[40] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/docs2.fox2",
						mapID = 4,
						scanned = false,
		},
		[41] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0000|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs3.fox2",
						mapID = 1,
						scanned = false,
		},
		[42] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0001|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs3.fox2",
						mapID = 2,
						scanned = false,
		},
		[43] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0002|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs3.fox2",
						mapID = 3,
						scanned = false,
		},		
		[44] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "afn0_docs001_gim_n0003|srt_ebx0_main0_def_v00",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/docs3.fox2",
						mapID = 4,
						scanned = false,
		},	
	}

	HackingTerminals = {
		[1] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/terminals.fox2",
		},
		[2] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/terminals.fox2",
		},
		[3] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/terminals2.fox2",
		},
		[4] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/terminals2.fox2",
		},
		[5] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals.fox2",
		},
		[6] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals.fox2",
		},
		[7] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/terminals.fox2",
		},
		[8] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/terminals.fox2",
		},
		[9] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/terminals2.fox2",
		},
		[10] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/terminals2.fox2",
		},
		[11] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/terminals.fox2",
		},
		[12] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/terminals.fox2",
		},
		[13] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/terminals2.fox2",
		},
		[14] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/terminals2.fox2",
		},
		[15] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/terminals.fox2",
		},
		[16] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/terminals.fox2",
		},
		[17] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/terminals2.fox2",
		},
		[18] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/terminals2.fox2",
		},
		[19] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals2.fox2",
		},
		[20] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals2.fox2",
		},
		[21] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0000|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals3.fox2",
		},
		[22] = {
						type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
						name = "mgo_terminal_gim_n0001|srt_terminal",
						dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/terminals3.fox2",
		},		
	}

	nukeGimmick = {
		[1] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/missile.fox2",
		},
		[2] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afc0/block_ruleset/attack/missile2.fox2",
		},
		[3] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/missile.fox2",
		},
		[4] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/missile.fox2",
		},
		[5] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afn0/block_ruleset/attack/missile2.fox2",
		},
		[6] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/missile.fox2",
		},
		[7] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afda/block_ruleset/attack/missile2.fox2",
		},
		[8] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/missile.fox2",
		},
		[9] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/cuba/block_ruleset/attack/missile2.fox2",
		},
		[10] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/missile2.fox2",
		},
		[10] = {
				type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				name = "mgo_nuke001_gim_n0000|srt_nuke",
				dataset = "/Assets/mgo/level/location/afc1/block_ruleset/attack/missile3.fox2",
		},
	}
end





return this






