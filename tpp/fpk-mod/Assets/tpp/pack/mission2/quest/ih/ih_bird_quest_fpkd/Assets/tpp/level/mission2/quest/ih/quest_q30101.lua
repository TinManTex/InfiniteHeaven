local this={}
local quest_step={}

local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local GetGameObjectId=GameObject.GetGameObjectId

this.QUEST_TABLE={
  questType=TppDefine.QUEST_TYPE.ANIMAL_RECOVERED,

  cpList={
    nil
  },

  enemyList={
    nil
  },

  vehicleList={
    nil
  },

  hostageList={
    nil
  },

  animalList={
    {
      birdList={
        {
          name="ih_raven_0000",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=0,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0001",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=5,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0002",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=10,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0003",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=17,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0004",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=0,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0005",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=5,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0006",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=10,
          height=5,
          ground={-679.108,29.809,534.532},
        },
        {
          name="ih_raven_0007",
          birdType="TppCritterBird",
          center={-679.108,31.5,534.532},
          radius=17,
          height=5,
          ground={-679.108,29.809,534.532},
        },
      },
    }
  },

  targetList={
    nil
  },

  targetAnimalList={
    markerList={
      "ih_raven_0000",
      "ih_raven_0001",
      "ih_raven_0002",
      "ih_raven_0003",
      "ih_raven_0004",
      "ih_raven_0005",
      "ih_raven_0006",
      "ih_raven_0007",
    },
    nameList={
      "ih_raven_0000",
      "ih_raven_0001",
      "ih_raven_0002",
      "ih_raven_0003",
      "ih_raven_0004",
      "ih_raven_0005",
      "ih_raven_0006",
      "ih_raven_0007",
    },
  },
}

function this.OnAllocate()
  TppQuest.RegisterQuestStepList{
    "QStep_Start",
    "QStep_Main",
    nil
  }
  TppQuest.RegisterQuestStepTable(quest_step)
  TppQuest.RegisterQuestSystemCallbacks{
    OnActivate=function()
      TppEnemy.OnActivateQuest(this.QUEST_TABLE)
      TppAnimal.OnActivateQuest(this.QUEST_TABLE)
    end,
    OnDeactivate=function()
      TppEnemy.OnDeactivateQuest(this.QUEST_TABLE)
      TppAnimal.OnDeactivateQuest(this.QUEST_TABLE)
    end,
    OnOutOfAcitveArea=function()
    end,
    OnTerminate=function()
      TppEnemy.OnTerminateQuest(this.QUEST_TABLE)
      TppAnimal.OnTerminateQuest(this.QUEST_TABLE)
    end,
  }

  mvars.fultonClearType=0
end

this.Messages=function()
  return
    StrCode32Table{
      Block={
        {
          msg="StageBlockCurrentSmallBlockIndexUpdated",
          func=function()end,
        },
      },
    }
end

function this.OnInitialize()
  TppQuest.QuestBlockOnInitialize(this)
end

function this.OnUpdate()
  TppQuest.QuestBlockOnUpdate(this)
end

function this.OnTerminate()
  TppQuest.QuestBlockOnTerminate(this)
end

quest_step.QStep_Start = {
  OnEnter=function()
    TppQuest.SetNextQuestStep("QStep_Main")
  end,
}

quest_step.QStep_Main={
  Messages=function(self)
    return
      StrCode32Table{
        GameObject={
          {
            msg="Dead",
            func=function(gameObjectId,gameObjectId01,animalId)
              local isClearType=TppAnimal.CheckQuestAllTarget(this.QUEST_TABLE.questType,"Dead",gameObjectId,animalId)
              TppQuest.ClearWithSave(isClearType)
            end
          },
          {
            msg="Fulton",
            func=function(gameObjectId,animalId)
              mvars.fultonClearType=TppAnimal.CheckQuestAllTarget(this.QUEST_TABLE.questType,"Fulton",gameObjectId,animalId)
            end
          },
          {
            msg="FultonInfo",
            func=function(gameObjectId,animalId)
              if mvars.fultonClearType~=0 then
                TppQuest.ClearWithSave(mvars.fultonClearType)
              end
            end
          },
          {
            msg="FultonFailed",
            func=function(gameObjectId,locatorName,locatorNameUpper,failureType)
              local isClearType=TppAnimal.CheckQuestAllTarget(this.QUEST_TABLE.questType,"FultonFailed",gameObjectId,locatorName)
              TppQuest.ClearWithSave(isClearType)
            end
          },
        },
      }
  end,
  OnEnter=function()
    Fox.Log("QStep_MainOnEnter")
  end,
  OnLeave=function()
    Fox.Log("QStep_MainOnLeave")
  end,
}

return this
