local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

local QUEST_TARGET_NAME = "quest_target"
local QUEST_TARGET_ROUTE = "rt_quest_animal001"

local TimerStart = GkEventTimerManager.Start

local resetGimmickIdTable = {
	
	"waterway_arch001",	
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Demo",
		"QStep_Demo_Vehicle",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = function()
			Fox.Log("qest_bossQuiet_00 OnDeactivate")
			
			mvars.q99010_questActive = false
			
			
			TppBuddyService.SetIgnoreDisableNpc( false )
			Vehicle.SetIgnoreDisableNpc( false )		
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("qest_bossQuiet_00 OnOutOfAcitveArea")

			





		end,
		OnTerminate = function()
			Fox.Log("qest_bossQuiet_00 OnTerminate")
		end,
	}
end




function this.Messages()
	return
	StrCode32Table {
		Block = {
			{
				msg = "StageBlockCurrentSmallBlockIndexUpdated",
				func = function() end,
			},
		},
	}
end






function this.OnActivate()
	Fox.Log("qest_bossQuiet_00 activate")

	
	Fox.Log("#### qest_bossQuiet_00::OnActivate #### Unreal quiet on quest active.")
	this.DeactivateQuiet(true)

	
	Fox.Log("#### qest_bossQuiet_00::OnActivate #### Reset gimmick on quest active.")
	for i, gimmickId in pairs( resetGimmickIdTable ) do
		TppGimmick.ResetGimmick{ gimmickId = gimmickId, searchFromSaveData = true }
	end







end




function this.OnInitialize()
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	TppQuest.QuestBlockOnUpdate( this )
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
end








quest_step.QStep_Start = {
	Messages = function( self )
		return
		StrCode32Table {
			Trap = {
				{
					
					msg = "Enter", sender = "trap_QuietShoot" ,		func =
					function()
						
						if ( mvars.f30010_trapInBeforeQuestActive ) or (mvars.startQuietShoot) then
							return
						end
						mvars.startQuietShoot = true
						Fox.Log("#### qest_bossQuiet_00:QStep_Start::trap_QuietShoot ####")

						
						this.RequestPerformBeforeDemo("normal")
					end,
				},
				{
					
					msg = "Enter", sender = "trap_AntiVehicle",		func =
					function()
						
						if ( mvars.f30010_trapInBeforeQuestActive ) or (mvars.startQuietShoot) then
							return
						end
						if(	this.isPlayerRideVehicle() )	then
							mvars.startQuietShoot = true
							
							
							this.RequestPerformBeforeDemo("vehicle")
						else
							Fox.Log("#### qest_bossQuiet_00:QStep_Start::trap_AntiVehicle #### Player not ride vehicle...")
						end
					end,
				},
				{
					
					msg = "Exit", sender = "trap_AntiVehicle",		func =
					function()
						
						if ( mvars.f30010_trapInBeforeQuestActive ) or (mvars.startQuietShoot) then
							return
						end
						if(	this.isPlayerRideVehicle() )	then
							mvars.startQuietShoot = true
							
							
							this.RequestPerformBeforeDemo("vehicle")
						else
							Fox.Log("#### qest_bossQuiet_00:QStep_Start::trap_AntiVehicle #### Player not ride vehicle...")
						end
					end,
				},
				{
					
					msg = "Enter",	sender = "trap_ActivateDD" ,	func = function()	this.ActivateDD(true)	end,
				},
				{
					
					msg = "Exit",	sender = "trap_ActivateDD",		func = function()	this.ActivateDD(false)	end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		
		mvars.q99010_questActive = true
		
		
		if ( mvars.f30010_trapInBeforeQuestActive ) then
			if ( mvars.startQuietShoot ) then
				return
			end
			Fox.Log("#### qest_bossQuiet_00:QStep_OnEnter #### Insurance processing! ")
			TppMain.DisablePause()
			
			
			this.RequestPerformBeforeDemo("insurance")
		end

		
		Fox.Log("#### qest_bossQuiet_00::OnEnter #### Reset gimmick.")
		for i, gimmickId in pairs( resetGimmickIdTable ) do
			TppGimmick.ResetGimmick{ gimmickId = gimmickId, searchFromSaveData = true }
		end
	end,

	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
	end,
}


quest_step.QStep_Demo = {
	Messages = function( self )
		return
		StrCode32Table {
			Timer = {
				{ msg = "Finish",	sender = "timer_MissionStart",	func =	function()	this.PlayDemoAndMissionStart()	end	},
				{ msg = "Finish",	sender = "timer_DisableNPC",	func =
					function()
						
						TppBuddyService.SetIgnoreDisableNpc( false )
						Vehicle.SetIgnoreDisableNpc( false )	
					end,
					option = { isExecDemoPlaying = true }
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Demo OnEnter")
		this.StartTimer( "timer_MissionStart", 0.8)
	end,

	OnLeave = function()
		Fox.Log("QStep_Demo OnLeave")
	end,
}

quest_step.QStep_Demo_Vehicle = {
	Messages = function( self )
		return
		StrCode32Table {
			Timer = {
				{ msg = "Finish",	sender = "timer_MissionStart",	func =
					function()
						Fox.Log("#### qest_bossQuiet_00:QStep_Demo_Vehicle::DemoPlay #### p31_030100_000")
						
						
						if(this.isPlayerRideVehicle())	then
							this.StartBossQuietBattle()

						
						else
							this.PlayDemoAndMissionStart()
						end
					end
				},
				{	
					msg = "Finish",	sender = "timer_BreakArch",		func =
					function()
						
						if(mvars.isPlayed_BossQuietQuestDemo)then
							return
						end
						
						local targetType = TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION
						local targetGimmick = "afgh_rins001_vrtn019_gim_n0000|srt_afgh_rins001_vrtn019"
						local assetPath = "/Assets/tpp/level/location/afgh/block_large/waterway/afgh_waterway_asset.fox2"
						Gimmick.BreakGimmick(targetType, targetGimmick, assetPath, 0 )
					end
				},
				{ msg = "Finish",	sender = "timer_DisableNPC",	func =
					function()
						
						TppBuddyService.SetIgnoreDisableNpc( false )
						Vehicle.SetIgnoreDisableNpc( false )	
					end,
					option = { isExecDemoPlaying = true }
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Demo_Vehicle OnEnter")

		if (mvars.f30010_trapInBeforeQuestActive) then
			this.StartTimer( "timer_MissionStart", 2.0)		
		else
			this.StartTimer( "timer_MissionStart", 4.0 )	
		end
	end,

	OnLeave = function()
		Fox.Log("QStep_Demo_Vehicle OnLeave")
	end,
}


this.RequestPerformBeforeDemo = function(situation)

	
	this.DeactivateQuiet(false)
	
	
	if(situation == "normal") then
		this.RequestShoot("player")	
		TppQuest.SetNextQuestStep( "QStep_Demo" )
		
	
	elseif(situation == "vehicle")then
		this.RequestShoot("entrance")
		this.StartTimer( "timer_BreakArch", 0.8)
		TppQuest.SetNextQuestStep( "QStep_Demo_Vehicle" )

	
	elseif(situation == "insurance")then
		if (this.isPlayerRideVehicle()) then
			this.RequestShoot("player")	
			TppQuest.SetNextQuestStep( "QStep_Demo_Vehicle" )
			
		else
			this.RequestPerformBeforeDemo("normal")			
		end
	end
	
end

this.DeactivateQuiet = function( deactiveFlag )
	GameObject.SendCommand( { type="TppBossQuiet2", index=0 }, {id="SetForceUnrealze", flag=deactiveFlag} )
	Fox.Log("#### qest_bossQuiet_00 #### DeactivateQuiet [ "..tostring(deactiveFlag).." ]")
end

this.RequestShoot = function( target )
	local command = {}

	if ( target == "player" ) then
		command = { id="ShootPlayer" }
		
	elseif ( target == "entrance" ) then
		command = { id="ShootPosition", position="position" }
		command.position = {-1828.670, 360.220, -132.585}
	
	end
	
	if not( command == {} ) then
		GameObject.SendCommand( { type="TppBossQuiet2", index=0 }, command )
		Fox.Log("#### qest_bossQuiet_00 #### RequestShoot [ "..tostring(target).." ]")
		
		if ( target == "player" ) then
			local ridingGameObjectId = vars.playerVehicleGameObjectId
			if Tpp.IsHorse(ridingGameObjectId) then
				
				GameObject.SendCommand( ridingGameObjectId, { id = "HorseForceStop" } )
			elseif( Tpp.IsPlayerWalkerGear(ridingGameObjectId) or Tpp.IsEnemyWalkerGear(ridingGameObjectId) )then
				
				GameObject.SendCommand( ridingGameObjectId, { id = "ForceStop", enabled = true } )
			end
		end
		
		if (this.isPlayerRideVehicle()) then
			this.ChangeVehicleSettingForEvent()
		end
	end
end

this.isPlayerRideVehicle = function()
	local ridingGameObjectId	= vars.playerVehicleGameObjectId
	
	if (Tpp.IsVehicle(ridingGameObjectId)) then
		return true
	else
		return false
	end
end

this.ChangeVehicleSettingForEvent = function()
	local vehicleId	= vars.playerVehicleGameObjectId
	
	
	if	( GameObject.SendCommand( vehicleId, { id="IsAlive", } ) ) then
		Fox.Log("#### qest_bossQuiet_00 #### ChangeVehicleSettingForEvent")

		
		GameObject.SendCommand( vehicleId, { id="SetBodyDamageRate", rate=100.0, } )
		GameObject.SendCommand( vehicleId, { id="ForceStop", enabled=true, } )
	else
		Fox.Log("#### qest_bossQuiet_00 #### ChangeVehicleSettingForEvent [ not execute! ] ")
	end
end

this.PlayDemoAndMissionStart = function()
	if (mvars.isPlayed_BossQuietQuestDemo) then
		return
	end
	mvars.isPlayed_BossQuietQuestDemo = true
	
	
	TppMusicManager.StopMusicPlayer( 500 )
	
	
	Fox.Log("#### qest_bossQuiet_00 #### PlayDemoAndMissionStart::demo [ p31_030100_000 ]")
	
	
	TppBuddyService.SetIgnoreDisableNpc( true )
	
	
	if (this.isPlayerRideVehicle()) then
		Vehicle.SetIgnoreDisableNpc( true )
	end
	
	
	TppDemo.Play("Demo_AttackedByQuiet_1",
		{ onEnd = function()
			Fox.Log("#### qest_bossQuiet_00 #### PlayDemoAndMissionStart::demo [ p31_030100_001 ]")
			
			
			this.StartTimer( "timer_DisableNPC", 2)
			
			
			TppDemo.Play("Demo_AttackedByQuiet_2",
				{ onEnd = function()
					Fox.Log("#### qest_bossQuiet_00 #### PlayDemoAndMissionStart::mission [ s10050 ]")

					
					this.StartBossQuietBattle()
				end	},
				{
					finishFadeOut = true,					
					waitBlockLoadEndOnDemoSkip	= false,	
					isSnakeOnly = false,
				}
			)
		end	},
		{	
			isSnakeOnly = false,
		}
	)
	
end

this.StartBossQuietBattle = function()
	TppMission.ReserveMissionClear{
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END,
		nextMissionId = 10050
	}
end

this.ActivateDD = function( activateFlag )
	local gameObjectId	= { type="TppBuddyDog2", index=0 }
	local command		= { id = "LuaAiStayAndSnarl" }		

	if ( activateFlag ) then
		
		local pos1 = Vector3(-1831.112, 351.344, -127.211)	
		local pos2 = Vector3(-1673.635,373.1427,-355.2032)	

		command = { id = "LuaAiStayAndSnarl", position=pos1, look=pos2 }
	end
	
	
	if GameObject.GetGameObjectIdByIndex( "TppBuddyDog2",0 ) ~= GameObject.NULL_ID then
		Fox.Log("#### qest_bossQuiet_00 #### ActivateDD [ "..tostring(activateFlag).." ]")
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### qest_bossQuiet_00 #### ActivateDD [ not execute! ] because DD not exist...")
	end
end


this.StartTimer = function( timerName, timerTime )
	if not GkEventTimerManager.IsTimerActive( timerName ) then
		Fox.Log( "#### qest_bossQuiet_00.StartTimer #### timerName = " ..tostring(timerName).. ", timerTime = " .. tostring(timerTime))
		GkEventTimerManager.Start( timerName, timerTime )
	end
end

return this