-- ih_quest_q30103.lua
-- IH quest definition - example quest, afgh wailo village hostage
local this={
  questPackList={
    "/Assets/tpp/pack/mission2/ih/ih_hostage_base.fpk",--base hostage pack
    "/Assets/tpp/pack/mission2/ih/prs3_main0_mdl.fpk",--model pack, edit the partsType in the TppHostage2Parameter in the quest .fox2 to match, see InfBodyInfo.lua for different body types.
    "/Assets/tpp/pack/mission2/quest/ih/ih_example_quest.fpk",--quest fpk
    "/Assets/tpp/pack/mission2/common/mis_com_walkergear.fpk",--TppDefine.MISSION_COMMON_PACK.WALKERGEAR
    "/Assets/tpp/pack/mission2/ih/ih_walker_gear_loc_quest.fpk",
    randomFaceList={--for hostage isFaceRandom, see TppQuestList
      race={TppDefine.QUEST_RACE_TYPE.ASIA},
      gender=TppDefine.QUEST_GENDER_TYPE.WOMAN
    }
  },
  locationId=TppDefine.LOCATION_ID.AFGH,
  areaName="field",--tex use the 'Show position' command in the debug menu to print the quest area you are in to ih_log.txt, see TppQuest. afgAreaList,mafrAreaList,mtbsAreaList. 
  --If areaName doesn't match the area the iconPos is in the quest fpk will fail to load (even though the Commencing Sideop message will trigger fine).
  iconPos=Vector3(489.741,321.901,1187.506),--position of the quest area circle in idroid
  radius=4,--radius of the quest area circle
  category=TppQuest.QUEST_CATEGORIES_ENUM.PRISONER,--Category for the IH selection/filtering options.
  questCompleteLangId="quest_extract_hostage",--Used for feedback of quest progress, see REF questCompleteLangId in InfQuest
  canOpenQuest=InfQuest.AllwaysOpenQuest,--function that decides whether the quest is open or not
  questRank=TppDefine.QUEST_RANK.G,--reward rank for clearing quest, see TppDefine.QUEST_BONUS_GMP and TppHero.QUEST_CLEAR
  hasEnemyHeli=false,--set to true if you have added heliList in the quest script.
}

--quest script, in the normal games quests the following is it's own script in the quest fpk,
--instead that script is making a call to InfQuest.GetScript"ih_quest_q30155" to use this script as the quest script.
--The main benefit is you can edit the script then reload scripts in game by holding <STANCE>,<ACTION>,<HOLD>,<SUBJECT>, or via the IH debug menu, 
--then reload a check point and the quest will start with the changes.
--this method should mostly be used only while developing as it will increase the load time of the game.
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
  },
  
  vehicleList = {
    nil
  },
  
  hostageList = {
    {
      hostageName   = TARGET_HOSTAGE_NAME,
      isFaceRandom  = true,
      voiceType   = { "hostage_c", "hostage_b", },
      langType    = "english",
      bodyId      = TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_FEMALE,
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
  end,
  OnLeave = function()
    Fox.Log("QStep_Main OnLeave")
  end,
}

return this

