--pilot_quest.lua
local this={}

local quest_step={}

local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local GetGameObjectId=GameObject.GetGameObjectId

local TARGET_HOSTAGE_NAME="hos_quest_0000"

this.QUEST_TABLE = {
  questType=TppDefine.QUEST_TYPE.RECOVERED,

  isQuestArmor=true,
  soldierSubType="PF_B",

  cpList={
    {
      cpName="quest_cp",
      cpPosition_x=2405.568,cpPosition_y=85.256,cpPosition_z=-965.218,cpPosition_r=50.0,
      isOuterBaseCp=true,
      gtName="gt_quest_0000",
      gtPosition_x=2405.568,gtPosition_y=85.256,gtPosition_z=-965.218,gtPosition_r=50.0,
    },
  },

  enemyList={
    {
      setCp="mafr_factoryWest_ob",
      isDisable=true,
    },
    {
      enemyName="sol_quest_0000",
      route_d="rt_quest_d_0000",
      route_c="rt_quest_c_0000",
      powerSetting={"QUEST_ARMOR","SHOTGUN"},
      soldierSubType="PF_B",
    },
    {
      enemyName="sol_quest_0001",
      route_d="rt_quest_d_0002",
      route_c="rt_quest_c_0002",
      powerSetting={"QUEST_ARMOR","SHOTGUN"},
      soldierSubType="PF_B",
    },
    {
      enemyName="sol_quest_0002",
      route_d="rt_quest_d_0001",
      route_c="rt_quest_d_0001",
      powerSetting={"QUEST_ARMOR","MG"},
      soldierSubType="PF_B",
    },
    {
      enemyName="sol_quest_0003",
      route_d="rt_quest_d_0001",
      route_c="rt_quest_d_0001",
      powerSetting={"QUEST_ARMOR","MG"},
      soldierSubType="PF_B",
    },
    {
      enemyName="sol_quest_0004",
      route_d="rt_quest_d_0001",
      route_c="rt_quest_d_0001",
      powerSetting={"QUEST_ARMOR","MG"},
      soldierSubType="PF_B",
    },
    {
      enemyName="sol_quest_0005",
      route_d="rt_quest_d_0001",
      route_c="rt_quest_d_0001",
      powerSetting={"QUEST_ARMOR","MG"},
      soldierSubType="PF_B",
    },
  },

  vehicleList={
  },

  hostageList={
    {
      hostageName=TARGET_HOSTAGE_NAME,
      voiceType={"hostage_a"},
      langType="english",
      position={pos={2631.449,98.002,-1839.696},rotY=0.069,},
    },
  },

  targetList={
    TARGET_HOSTAGE_NAME,
  },
}

function this.OnAllocate()
  TppQuest.QuestBlockOnAllocate(this)
  TppQuest.RegisterQuestStepList{
    "QStep_Start",
    "QStep_Main",
    nil
  }

  TppEnemy.OnAllocateQuestFova(this.QUEST_TABLE)

  TppQuest.RegisterQuestStepTable(quest_step)
  TppQuest.RegisterQuestSystemCallbacks{
    OnActivate=function()
      TppEnemy.OnActivateQuest(this.QUEST_TABLE)
    end,
    OnDeactivate=function()
      TppEnemy.OnDeactivateQuest(this.QUEST_TABLE)
    end,
    OnOutOfAcitveArea=function()
    end,
    OnTerminate=function()
      TppEnemy.OnTerminateQuest(this.QUEST_TABLE)
    end,
  }

  mvars.fultonInfo=TppDefine.QUEST_CLEAR_TYPE.NONE
end


this.Messages=function()
  return StrCode32Table{}
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

quest_step.QStep_Start={
  OnEnter=function()
    InfCore.PCall(this.WarpHostages)
    for i,hostageInfo in pairs(this.QUEST_TABLE.hostageList) do
      local gameObjectId=GameObject.GetGameObjectId("TppHostageUnique",hostageInfo.hostageName)
      GameObject.SendCommand(gameObjectId,{id="SetHostage2Flag",flag="unlocked",on=true,})
      GameObject.SendCommand(gameObjectId,{id="SetHostage2Flag",flag="disableFulton",on=true})
      GameObject.SendCommand(gameObjectId,{id="SetHostage2Flag",flag="disableScared",on=true})
    end

    TppQuest.SetNextQuestStep("QStep_Main")
  end,
}

quest_step.QStep_Main={
  Messages=function(self)
    return
      StrCode32Table{
        GameObject={
          {msg="Dead",
            func=function(gameObjectId)
              local isClearType=TppEnemy.CheckQuestAllTarget(this.QUEST_TABLE.questType,"Dead",gameObjectId)
              TppQuest.ClearWithSave(isClearType)
            end},
          {msg="FultonInfo",
            func=function(gameObjectId)
              if mvars.fultonInfo~=TppDefine.QUEST_CLEAR_TYPE.NONE then
                TppQuest.ClearWithSave(mvars.fultonInfo)
              end
              mvars.fultonInfo=TppDefine.QUEST_CLEAR_TYPE.NONE
            end},
          {msg="Fulton",
            func=function(gameObjectId)
              local isClearType=TppEnemy.CheckQuestAllTarget(this.QUEST_TABLE.questType,"Fulton",gameObjectId)
              mvars.fultonInfo=isClearType
            end},
          {msg="FultonFailed",
            func=function(gameObjectId,locatorName,locatorNameUpper,failureType)
              if failureType==TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
                local isClearType=TppEnemy.CheckQuestAllTarget(this.QUEST_TABLE.questType,"FultonFailed",gameObjectId)
                TppQuest.ClearWithSave(isClearType)
              end
            end},
          {msg="PlacedIntoVehicle",
            func=function(gameObjectId,vehicleGameObjectId)
              if Tpp.IsHelicopter(vehicleGameObjectId)then
                local isClearType=TppEnemy.CheckQuestAllTarget(this.QUEST_TABLE.questType,"InHelicopter",gameObjectId)
                TppQuest.ClearWithSave(isClearType)
              end
            end},
        },
      }
  end,
  OnEnter=function()
  --InfCore.Log("QStep_MainOnEnter")
  end,
  OnLeave=function()
  --InfCore.Log("QStep_MainOnLeave")
  end,
}

function this.WarpHostages()
  for i,hostageInfo in ipairs(this.QUEST_TABLE.hostageList)do
    local gameObjectId=GameObject.GetGameObjectId(hostageInfo.hostageName)
    if gameObjectId~=GameObject.NULL_ID then
      local position=hostageInfo.position
      local command={id="Warp",degRotationY=position.rotY,position=Vector3(position.pos[1],position.pos[2],position.pos[3])}
      GameObject.SendCommand(gameObjectId,command)
    end
  end
end

return this

