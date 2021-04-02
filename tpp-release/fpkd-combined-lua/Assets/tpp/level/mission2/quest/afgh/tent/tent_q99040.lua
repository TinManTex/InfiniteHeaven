local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local TARGET_HOSTAGE_NAME = "hos_quest_0000"

this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			cpName = "afgh_tent_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0001",
			cpName = "afgh_tent_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0002",
			cpName = "afgh_tent_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_c_0003",
			cpName = "afgh_tent_cp",
			powerSetting = { },
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName = TARGET_HOSTAGE_NAME,
			path		= "/Assets/tpp/motion/SI_game/fani/bodies/vol0/vol0non/vol0non_s_ded_p.gani",
		},
	},
	
	targetList = {
		TARGET_HOSTAGE_NAME,
	},
}

function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	
	TppHostage2.SetHostageType{
		gameObjectType	= "TppHostageUnique",
		hostageType		= "Volgin",
	}

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			this.AddTrapSettingForVolginDemo{
				demoName = "Volgin",
				trapName = "trap_Start_VolginDemo",
				direction = 90,
				directionRange = 180,
			}
			mvars.isVolginDemoPlay = false
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}

	
	mvars.isHeliStart = false

end

this.Messages = function()
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
	OnEnter = function()
		
		local gameObjectId = GameObject.GetGameObjectId("TppHostageUnique", TARGET_HOSTAGE_NAME )
		local command = {	id = "SetHostage2Flag", flag = "commonNpc",	on = true, }	
		GameObject.SendCommand( gameObjectId, command )
		
		local cmdHosState = {
				id = "SetHostage2Flag",
				flag = "disableFulton", 
				on = true,
		}
		GameObject.SendCommand( gameObjectId, cmdHosState )
		
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

quest_step.QStep_Main = {
	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "Dead",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Dead", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "FultonFailed",
					func = function( gameObjectId, locatorName, locatorNameUpper, failureType )
						if failureType == TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "FultonFailed", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
			},
			Trap = {
























				
				{
					msg = "Enter",	
					func = function (arg0,arg1)
						if arg0 == StrCode32("trap_Start_VolginDemo") then
							this.ShowIconForVolginDemo( "Volgin", mvars.isVolginDemoPlay )
						end
					end
				},
				
				{
					msg = "Exit",	
					func = function (arg0,arg1)
						if arg0 == StrCode32("trap_Start_VolginDemo") then
							this.HideIconForVolginDemo()
						end
					end
				},
			},
			Player = {
				
				{
					msg = "Volgin_Start", sender = "Volgin",
					func = function()
						this.Reload_BeforeDemoPlay()	
					end,
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,
}

function this.AddTrapSettingForVolginDemo( params )
	local trapName = params.trapName
	local direction = params.direction or 0
	local directionRange = params.directionRange or 45
	local demoName = params.demoName

	if not Tpp.IsTypeString(trapName) then
		Fox.Error("Invalid trap name. trapName = " .. tostring(trapName) )
	end

	Fox.Log("tent_q99040.AddTrapSettingForVolginDemo. trapName = " .. tostring(trapName) .. ", direction = " .. tostring(direction) .. ", directionRange = " .. tostring(directionRange) )

	mvars.Volgin_TrapInfo = mvars.Volgin_TrapInfo or {}

	if demoName then
		mvars.Volgin_TrapInfo[demoName] = { trapName = trapName }
	else
		Fox.Error("tent_q99040.AddTrapSettingForVolginDemo: Must set demo name.")
	end

	Player.AddTrapDetailCondition {
		trapName = trapName,
		condition = PlayerTrap.FINE,
		action = ( PlayerTrap.NORMAL + PlayerTrap.CARRY ),
		stance = (PlayerTrap.STAND + PlayerTrap.SQUAT ),
		direction = direction,
		directionRange = directionRange,
	}
end

function this.ShowIconForVolginDemo( demoName, doneCheckFlag )
	if not Tpp.IsTypeString(demoName) then
		Fox.Error("invalid demo name. demoName = " .. tostring(demoName) )
		return
	end

	local trapName
	if mvars.Volgin_TrapInfo and mvars.Volgin_TrapInfo[demoName] then
		trapName = mvars.Volgin_TrapInfo[demoName].trapName
	end

	if not doneCheckFlag then
		if Tpp.IsNotAlert() then
			Fox.Log("tent_q99040.ShowIconForVolginDemo()")
			Player.RequestToShowIcon {
				type = ActionIcon.ACTION,
				icon = ActionIcon.FULTON,
				message = StrCode32("Volgin_Start"),
				messageArg = demoName,
			}
		elseif trapName then
			this.HideIconForVolginDemo()
			Player.SetWaitingTimeToTrapDetailCondition { trapName = trapName, time = 2.0 }
			
		else
			
		end
	end
end

function this.HideIconForVolginDemo()
	Fox.Log("tent_q99040.ShowIconForVolginDemo()")
	Player.RequestToHideIcon{
		type = ActionIcon.ACTION,
		icon = ActionIcon.FULTON,
	}
end

function this.Reload_BeforeDemoPlay()
	Fox.Log("**** tent_q99040:Reload_BeforeDemoPlay ****")
	
	
	TppMission.Reload{
		isNoFade = false,
		showLoadingTips = false,
		missionPackLabelName = "recoverVolginDemo",
		OnEndFadeOut = function()
			TppSequence.SetNextSequence("Seq_Demo_RecoverVolgin")
			
			TppMission.UpdateCheckPointAtCurrentPosition()
			
			
			
			
		end,
	}
end

return this