local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID








this.RouteSets = {

	Spy = {
		plnt0 = {
			day = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_q101220_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_q101220_0001",
			},
			night = {
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_q101220_0000",
				"ly003_cl05_route0000|cl05pl0_uq_0050_free|rt_q101220_0001",
			},
		},
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = function()
			Fox.Log("quest_q101220 OnDeactivate")
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest_q101220 OnOutOfAcitveArea")

			



			
		end,
		OnTerminate = function()
			Fox.Log("quest_q101220 OnTerminate")
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
	Fox.Log("quest_q101220 activate")
	mvars.qst_spch_soldierList = {}
	local clusterId = 6
	local clusterName = mtbs_cluster.GetClusterName(clusterId)
	local day = TppClock.GetTimeOfDay()
	local routeList = this.RouteSets[clusterName]
	local plntName = "plnt0"
	local routeSets = routeList[plntName][day]
	
	
	local femaleSoldierList = f30050_sequence.GetFemaleSoldierList(clusterId, 2)
	
	if #femaleSoldierList < 2 then
		return 
	end
	
	for i, soldierName in ipairs( femaleSoldierList ) do
		local routeName = routeSets[i]
		local gameObjectId = GetGameObjectId("TppSoldier2", soldierName)
		
		TppEnemy.SetDisable( gameObjectId )
		TppEnemy.SetSneakRoute( gameObjectId, routeName )

		table.insert(mvars.qst_spch_soldierList, gameObjectId )	
		
	end
	mvars.qst_smok_waitSoldierDisableFrame = 5
	mvars.qst_canGetFemaleSoldier = true
end




function this.OnInitialize()	
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	
	if mvars.qst_smok_waitSoldierDisableFrame and mvars.qst_smok_waitSoldierDisableFrame > 0 then
		mvars.qst_smok_waitSoldierDisableFrame = mvars.qst_smok_waitSoldierDisableFrame - 1
		if mvars.qst_smok_waitSoldierDisableFrame == 0 then
			this._EnableSoldiers()
		end
	end
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
					sender = "ly003_cl05_route0000|cl05pl0_uq_0050_free|trap_q101220",
					func = function ()
						if mvars.qst_canGetFemaleSoldier then
							this.SpeechStart()
						else
							Fox.Log("Cannot Get Female Soldier")
						end
					end,
				},
			},

			GameObject = {
				{
					msg = "ConversationEnd",				
					func = function( cpGameObjectId, speechLabel, isSuccess )
						Fox.Log( "this.Messages(): ConversationEnd Message Received. gameObjectId:" ..
							tostring( gameObjectId ) .. ", speechLabel:" .. tostring( speechLabel ) .. ", isSuccess:" .. isSuccess )
						if speechLabel == StrCode32("MB_story_18") then
							this._ResetSoldiers()
						end
					end
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		TppQuest.ClearWithSaveMtbsDDQuest()
	end,
	
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
		this._ResetSoldiers()	
	end,
}


this._EnableSoldiers = function()
	for _, gameObjectId in ipairs( mvars.qst_spch_soldierList ) do
		TppEnemy.SetEnable( gameObjectId )
	end
end


this._ResetSoldiers = function()
	if mvars.qst_spch_soldierList then	
		for _, gameObjectId in ipairs( mvars.qst_spch_soldierList ) do
			TppEnemy.UnsetSneakRoute(gameObjectId)
		end
	end
end



this.SetConversation = function( speakerGameObjectId, friendGameObjectId, speechLabel )
        Fox.Log("*** SetConversation ***")
        Fox.Log( "speaker:" .. tostring( speakerGameObjectId ) .. " friend:" .. tostring(friendGameObjectId) .. "speechLabel:" .. tostring( speechLabel ) )

        local command = { id = "CallConversation", label = speechLabel, friend  = friendGameObjectId, }
        GameObject.SendCommand( speakerGameObjectId, command )
end



this.SpeechStart = function()
	if mvars.qst_spch_soldierList then	
		if #mvars.qst_spch_soldierList >= 2 then
			local SPEAKER =	mvars.qst_spch_soldierList[1]
			local FRIEND =	mvars.qst_spch_soldierList[2]
			this.SetConversation( SPEAKER, FRIEND, "MB_story_19")
		end
	end
end


return this