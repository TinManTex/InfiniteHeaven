--quest_example.lua
--quest example quest script.

local useExternalScript=true--

if useExternalScript then
	--tex load the MGS_TPP\mod\quests script in place of this, should only be used while doing a lot of script development to allow you to reload the scripts while in-game
	--see notes in ih_quest_q30103.lua
	InfQuest.GetScript("ih_quest_q30103")
end

local this = {}

local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local TARGET_HOSTAGE_NAME = "hos_quest_0000"

--DEBUGNOW
this.walkerList={
	"wkr_WalkerGear_quest_0000",
	"wkr_WalkerGear_quest_0001",
	"wkr_WalkerGear_quest_0002",
	"wkr_WalkerGear_quest_0003",
}


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName		= TARGET_HOSTAGE_NAME,
			isFaceRandom	= true,
			voiceType		= { "hostage_c", "hostage_b", },
			langType		= "english",
			bodyId			= TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_FEMALE,
		},
	},
	
	targetList = {
		TARGET_HOSTAGE_NAME,
	},
}

function this.OnAllocate()
	 TppQuest.QuestBlockOnAllocate( this )
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	
	TppEnemy.OnAllocateQuestFova( this.QUEST_TABLE )


	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
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
					msg = "FultonInfo",
					func = function( gameObjectId )
						if mvars.fultonInfo ~= TppDefine.QUEST_CLEAR_TYPE.NONE then
							TppQuest.ClearWithSave( mvars.fultonInfo )
						end
						mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						mvars.fultonInfo = isClearType
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
				{	
					msg = "PlacedIntoVehicle",
					func = function( gameObjectId, vehicleGameObjectId )
						if Tpp.IsHelicopter( vehicleGameObjectId ) then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "InHelicopter", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
		this.WarpWalkerGears()--DEBUGNOW
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,
}

local positionsList={
  {566.121,320.827,1061.825},
  {567.121,320.827,1061.825},
  {568.121,320.827,1061.825},
  {569.121,320.827,1061.825},
}

local positionBag=InfUtil.ShuffleBag:New()
for i,coords in ipairs(positionsList)do
  positionBag:Add(coords)
end

function this.WarpWalkerGears()
  local objectList=this.walkerList

  for i,name in ipairs(objectList)do
    local pos=positionBag:Next()
    local rotY=math.random(360)

	local gameId=GetGameObjectId("TppCommonWalkerGear2",name)
	if gameId==NULL_ID then
		InfCore.Log("WARNING NULL_ID for "..name)
	else
		local command={id="SetPosition",pos={pos[1],pos[2],pos[3]},rotY=rotY}
		GameObject.SendCommand(gameId,command)
	end
  end
end


return this
