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
    }
  },

  targetList={
    nil
  },

  targetAnimalList={
    markerList={
      "anml_rat_00",
      "anml_rat_01",
      "anml_rat_02",
      "anml_rat_03",
      "anml_rat_04",
      "anml_rat_05",
    },
    nameList={
      "anml_rat_00",
      "anml_rat_01",
      "anml_rat_02",
      "anml_rat_03",
      "anml_rat_04",
      "anml_rat_05",
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
    this.WarpRats()
  end,
  OnLeave=function()
    Fox.Log("QStep_MainOnLeave")
  end,
}

local positionsList={
  {359.466,-4.413,850.132},
  {356.234,-4.413,856.585},
  {360.531,-4.413,865.436},
  {355.715,-4.413,871.195},
  {359.369,-4.413,877.347},
  {368.626,-4.413,866.201},
  {368.027,-4.413,876.324},
  {376.112,-4.413,875.328},
  {374.444,-4.413,866.858},
  {383.520,-4.413,870.073},
  {384.246,-4.413,860.197},
  {386.223,-4.413,847.923},
  {375.588,-4.413,852.175},
  {374.930,-4.413,858.982},
  {366.645,-4.413,849.100},
}

local positionBag=InfMain.ShuffleBag:New()
for i,coords in ipairs(positionsList)do
  positionBag:Add(coords)
end

function this.WarpRats()
  local ratList=this.QUEST_TABLE.targetAnimalList.nameList

  local tppRat={type="TppRat",index=0}
  for i,name in ipairs(ratList)do
    local pos=positionBag:Next()
    local rotY=math.random(360)
    local route=""

    local command={id="Warp",name=name,ratIndex=0,position=pos,degreeRotationY=rotY,route=route,nodeIndex=0}
    GameObject.SendCommand(tppRat,command)
  end
end

return this
