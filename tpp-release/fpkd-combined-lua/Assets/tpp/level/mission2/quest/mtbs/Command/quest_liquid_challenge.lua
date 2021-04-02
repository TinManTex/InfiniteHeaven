local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

local GAMEOBJECT_LIQUID = "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppLiquid2GameObjectLocator"
local PLAYER_DISABLE_ACTION_FLAG = PlayerDisableAction.CQC_KNIFE_KILL + PlayerDisableAction.KILLING_WEAPON + PlayerDisableAction.TIME_CIGARETTE



function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Demo",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest liquid challenge OnActivate")
			this.OnActivateSetupLiquid()
			this.OnActivateSetupEnemy()
		end,
		OnDeactivate = function()
			Fox.Log("quest liquid challenge OnDeactivate")
			TppSound.StopSceneBGM()
			this.OnDeactivateEnemy()
			
			f30050_sequence.ResetPlayerDisableActionSIDEOPS()
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest liquid challenge OnOutOfAcitveArea")
		end,
		OnTerminate = function()
			Fox.Log("quest liquid challenge OnTerminate")
		end,
	}
	
	
	mvars.qst_liquid_gameObjectId = nil
	
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
		Tpp.StrCode32Table{
			GameObject = {
				{
					msg = "Unconscious",
					func = function( gameObjectId )
						if gameObjectId == mvars.qst_liquid_gameObjectId then
							GkEventTimerManager.Start( "TimerLiquidQuestEnd", 1.0 )
						end
					end,
				},
			},
			UI = {
				{
					msg = "QuestAreaAnnounceLog",
					func = function()
						TppSound.SetSceneBGM( "bgm_eli_challenge" )
					end
				},
				{
					msg = "EndFadeOut", sender = "LiquidUnconsciousFade",
					func = function()
						TppQuest.SetNextQuestStep( "QStep_Demo" )
					end,
				},
			},
			Timer = {
				{
					msg = "Finish",
					sender = "TimerLiquidQuestEnd",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEEDD, "LiquidUnconsciousFade" )
						TppSound.StopSceneBGM()
					end,
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		
		mtbs_enemy.SetEnableSoldierInCluster(1,true)
		
		mvars.qst_liquid_gameObjectId = GameObject.GetGameObjectId( GAMEOBJECT_LIQUID )
		f30050_sequence.SetPlayerDisableActionSIDEOPS( PLAYER_DISABLE_ACTION_FLAG )
	end,
}

quest_step.QStep_Demo = {
	
	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		
		local translation, rotQuat = mtbs_cluster.GetDemoCenter( "Develop", "plnt1" )
		DemoDaemon.SetDemoTransform( f30050_demo.demoList.LiquidQuest, rotQuat, translation )
		
		TppDemo.Play(
			"LiquidQuest",
			{
				onStart = function()
					
				end,
				onEnd = function()
					
					this.OnLiquidDemoEnd()
					
					TppQuest.ClearWithSave( TppDefine.QUEST_CLEAR_TYPE.CLEAR )
					
					f30050_sequence.ResetPlayerDisableActionSIDEOPS()
				end,
			},
			{
				startNoFadeIn = true,
			}
		)
	end,
}








function this.OnActivateSetupLiquid()
	Fox.Log( "OnSetupLiquid ")
	
	local gameObjectId = { type="TppLiquid2", index=0 }  
	GameObject.SendCommand( gameObjectId, { id = "SetMotherbaseMode"} )
	GameObject.SendCommand( gameObjectId, { id = "InitiateCombat"} )
end




function this.OnLiquidDemoEnd()
	
	local gameObjectId = { type="TppLiquid2", index=0 }  
	GameObject.SendCommand( gameObjectId, { id = "SetForceUnrealize", forceUnrealize = true } )
end




function this.OnActivateSetupEnemy()
	Fox.Log( "OnSetupEnemy ")
	
	mvars.qst_disableSoldierList = mtbs_enemy.GetSoldierForQuest( "Develop", "plnt1", 99 )
	for i, soldierName in ipairs( mvars.qst_disableSoldierList ) do
		mtbs_enemy.RegisterDisableSoldierForQuest(soldierName)
	end

	
	local gameObjectId = { type="TppCommandPost2" } 
	local command = { id="SetChatEnable", enabled=false } 
	GameObject.SendCommand( gameObjectId, command ) 
end




function this.OnDeactivateEnemy()
	for _, soldierName in ipairs( mvars.qst_disableSoldierList ) do
		mtbs_enemy.UnregisterDisableSoldierForQuest(soldierName)
	end
	
	local gameObjectId = { type="TppCommandPost2" } 
	local command = { id="SetChatEnable", enabled=true } 
	GameObject.SendCommand( gameObjectId, command ) 
end


return this