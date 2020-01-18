local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_IDdem

local OcelotIdleMotionTime = 15































this.PlaySpeech = function ( speechSetTable )
	local locatorName = speechSetTable.speakerName
	local gameObjectType = speechSetTable.speakerType
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id = "CallMonologue",
		label = speechSetTable.speechLabel,
	}
	GameObject.SendCommand( gameObjectId, command )
end





function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Demo",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = this.OnDeactivate,
		OnOutOfAcitveArea = function()
			Fox.Log("qest_visit_quiet OnOutOfAcitveArea")
		end,
		OnTerminate = function()
			Fox.Log("qest_visit_quiet OnTerminate")
		end,
	}
end







function this.OnActivate()
	Fox.Log("qest_visit_quiet activate")
	local translation, rotY = Tpp.GetLocatorByTransform( "quiet_AssetIdentifier", "OcelotPosInVisitQuietStart" )
	rotY = Tpp.GetRotationY(rotY)
	if translation and rotY then
		local gameObjectId = { type="TppOcelot2", index=0 }
		local command = { id = "Warp", degRotationY = rotY, position = translation + Vector3(0,0.8,0) }
		GameObject.SendCommand(gameObjectId,command)
	else
		Fox.Error("Can not found ocelot position locator!")
	end
	
	
	local gameObjectId = { type="TppCommandPost2" } 
	local command = { id="SetChatEnable", enabled=false } 
	GameObject.SendCommand( gameObjectId, command ) 
	
	
	TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY )
	
	TppRadioCommand.DisableRadio()
end

function this.OnDeactivate()
	Fox.Log("on end visit quiet")
	
	local gameObjectId = { type="TppCommandPost2" } 
	local command = { id="SetChatEnable", enabled=true } 
	GameObject.SendCommand( gameObjectId, command ) 
	
	
	TppRadioCommand.EnableRadio()
	
	TppWeather.CancelRequestWeather()
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
					msg = "Enter",
					sender = "mtbs_uq0040_plnt0000|uq_00400000|uq_0040_path0000|trap_toQuietPrison",
					func = function()
						Fox.Log("Quiet Demo Trap On Enter")
						if vars.playerType == PlayerType.SNAKE then 
							TppQuest.SetNextQuestStep("QStep_Demo")
						else
							Fox.Log("Player is Avater! Skip Demo:playerPartsType:" ..tostring(vars.playerType) )
						end
					end,
				},
			},
		}
	end,


	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
	end,
	
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
	end,
}

quest_step.QStep_Demo = {	
	OnEnter = function()
		Fox.Log("QStep_Demo OnEnter")
		
		local translation, rotQuat = mtbs_cluster.GetDemoCenter("Medical", "plnt0")
		DemoDaemon.SetDemoTransform(f30050_demo.demoList.VisitQuiet, rotQuat, translation)
		GameObject.SendCommand( { type="TppMbQuiet", index=0 }, { id="StartWakeUp", isLoop=false, isAll=true } )
		
		
		TppDataUtility.SetVisibleDataFromIdentifier( "quiet_AssetIdentifier", "demo_collision", true, false)
		
		
		Player.RequestToSetTargetStance(PlayerStance.STAND)
		vars.playerDisableActionFlag =	  PlayerDisableAction.CQC
										+ PlayerDisableAction.KILLING_WEAPON
										+ PlayerDisableAction.FULTON
										+ PlayerDisableAction.CARRY
										+ PlayerDisableAction.BEHIND
										+ PlayerDisableAction.OPEN_CALL_MENU
										+ PlayerDisableAction.LOOK_CAMERA_DIR
										+ PlayerDisableAction.TIME_CIGARETTE
										+ PlayerDisableAction.MARKING
		Player.SetPadMask {
			
			settingName = "DemoVisitQuiet",    
			
			except = false,                                 
			
			buttons = PlayerPad.CQC 		
					+ PlayerPad.HOLD		
					+ PlayerPad.FIRE		
					+ PlayerPad.STANCE		
					+ PlayerPad.RELOAD		
					+ PlayerPad.EVADE		
					+ PlayerPad.ACTION      
					+ PlayerPad.CALL		
					+ PlayerPad.MB_DEVICE	
		}
		
		
		local flags = {
			isInGame = true,
			isNotAllowedPlayerAction = true,
		}
		local funcs = {
			onInit = function()
				
				local gameObjectId = { type="TppOcelot2", index=0 }
				local command = { id = "SetSneakRoute", route = "ly003_cl04_route0000|cl04pl0_uq_0040_free|OcelotDemoEnd" }
				GameObject.SendCommand( gameObjectId, command )
			end,
			onEnd = function()
				TppStory.SetDoneElapsedMission( TppDefine.ELAPSED_MISSION_EVENT.QUIET_VISIT_MISSION )
				TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "OnEndGameStartFadeIn" )
				if mtbs_cluster.GetCurrentClusterName() == "Medical" then
					if TppBuddyService.DidObtainBuddyType(BuddyType.QUIET) then
						TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
						TppStory.StartElapsedMissionEvent( TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION, TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_WITH_GO_MISSION )
					end
					TppQuest.ClearWithSave( TppDefine.QUEST_CLEAR_TYPE.CLEAR )
					f30050_sequence.ClearVisitQuiet()
				end 
			end,
		}
		TppDemo.Play( "VisitQuiet", funcs, flags )
	end,

















































	
	OnLeave = function()
		Fox.Log("QStep_Demo OnLeave")
		GameObject.SendCommand( { type="TppMbQuiet", index=0 }, { id="StartWakeUp", isLoop=true, isAll=false } )
		
		
		TppDataUtility.SetVisibleDataFromIdentifier( "quiet_AssetIdentifier", "demo_collision", false, false)
		
		
		Player.ResetPadMask {
			settingName = "DemoVisitQuiet",
		}
		f30050_sequence.SetDefaultPlayerDisableAction()
		this.EndLookOcelotInDemo()
		
		this.OnDeactivate()
	end,
}

function this.StartLookOcelotInDemo()
	local padMaskTime = 2
	
	Player.SetPadMask {
		
		settingName = "DemoLookTarget",    
		
		except = false,                                 
		
		sticks = PlayerPad.STICK_L
	}
	
	local gameObjectId = GameObject.GetGameObjectId( "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator" )
	local command = { id = "GetPosition" }
	local ocelotPosition = GameObject.SendCommand( gameObjectId, command )

	
	local dirVec = Vector3( ocelotPosition:GetX() - vars.playerPosX, 0, ocelotPosition:GetZ() - vars.playerPosZ )
	dirVec = dirVec:Normalize()
	local rotY =  TppMath.RadianToDegree( foxmath.Atan2(dirVec:GetX(), dirVec:GetZ() ) )
	
	Player.RequestToMoveToPosition{
        name = "LookToOcelot",  
        position = Vector3(vars.playerPosX,0,vars.playerPosZ),    
        direction = rotY,        
        moveType = PlayerMoveType.WALK, 
        timeout = padMaskTime,   
    }
    
    
	Player.StartTargetConstrainCamera {        
		cameraType = PlayerCamera.Around, 
		force = true,    
		fixed = true,
		recoverPreOrientation = false, 
		gameObjectName = "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
		skeletonName = "SKL_000_WAIST",
		interpTime = 0.5, 
		
		interpTimeToRecover = 0.5,
		
		time = padMaskTime,        
		cameraOffset = Vector3(0.6,0.5,0.0),        
		
		minDistance = 50.0,        
		doCollisionCheck = false,
		focalLength = 35.0,
		targetOffset = Vector3(-0.6,-0.5,0.0),
		targetOffsetInterpTime = 0.3,
	}    
end


function this.StartLookQuietInDemo()
	local padMaskTime = 10
	
	Player.SetPadMask {
		
		settingName = "DemoLookTarget",    
		
		except = false,                                 
		
		sticks = PlayerPad.STICK_L
	}
	
	local gameObjectId = GameObject.GetGameObjectId( "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator" )
	local command = { id = "GetPosition" }
	local ocelotPosition = GameObject.SendCommand( gameObjectId, command )

	
	local dirVec = Vector3( ocelotPosition:GetX() - vars.playerPosX, 0, ocelotPosition:GetZ() - vars.playerPosZ )
	dirVec = dirVec:Normalize()
	local rotY =  TppMath.RadianToDegree( foxmath.Atan2(dirVec:GetX(), dirVec:GetZ() ) )
	
	Player.RequestToMoveToPosition{
        name = "LookToQuiet",  
        position = Vector3(vars.playerPosX,0,vars.playerPosZ),    
        direction = rotY,        
        moveType = PlayerMoveType.WALK, 
        timeout = padMaskTime,   
    }
    
    
	Player.StartTargetConstrainCamera {        
		cameraType = PlayerCamera.Around, 
		force = true,    
		fixed = true,
		recoverPreOrientation = false, 
		gameObjectName = "ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|MbQuietLocator",
		skeletonName = "SKL_000_WAIST",
		interpTime = 0.5, 
		
		interpTimeToRecover = 0.5,
		
		time = padMaskTime,        
		cameraOffset = Vector3(0.6,0.5,0.0),        
		
		minDistance = 50.0,        
		doCollisionCheck = false,
		focalLength = 35.0,
		targetOffset = Vector3(-0.6,-0.5,0.0),
		targetOffsetInterpTime = 0.3,
	}    
end


function this.EndLookOcelotInDemo()
	
	Player.ResetPadMask {
		
		settingName = "DemoLookTarget",
	}
	Player.ResetPadMask {
		settingName = "LookOcelotDemoStart",    
	}
end


function this.LookOcelotDemoStart()
	local padMaskTime = 3.0
	
	Player.SetPadMask {
		
		settingName = "LookOcelotDemoStart",    
		
		except = false,                                 
		
		sticks = PlayerPad.STICK_L
	}
	
	GkEventTimerManager.Start( "PadMask_LookOcelotDemoStart", padMaskTime )
	
	Player.StartTargetConstrainCamera {        
			cameraType = PlayerCamera.Around, 
			force = true,    
			fixed = true,
			recoverPreOrientation = false, 
			gameObjectName = "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
			skeletonName = "SKL_000_WAIST",
			interpTime = 0.5, 
			
			interpTimeToRecover = 0.5,
			
			
			time = padMaskTime,        
			cameraOffset = Vector3(0.4,0.8,0.0),        
			
			minDistance = 50.0,        
			doCollisionCheck = false,
			focalLength = 35.0,
			targetOffset = Vector3(-0.6,-0.5,0.0),
			targetOffsetInterpTime = 0.3,
	}
end

return this