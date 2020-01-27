--InfMBGimmick.lua
local this={}

--LOCALOPT
local InfMain=InfMain
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand

this.debugModule=false

--TUNE
local RANGE_ALRM_LV01=2
local RANGE_ALRM_LV03=3
local TIME_ALRM_LV01=10
local TIME_ALRM_LV03=10

this.burgularAlarmRange=RANGE_ALRM_LV01
this.burgularAlarmTime=TIME_ALRM_LV01

this.registerIvars={
  'enableIRSensorsMB',
  'enableFultonAlarmsMB',
  'hideContainersMB',
  'hideAACannonsMB',
  'hideAAGatlingsMB',
  'hideTurretMgsMB',
  'hideMortarsMB',
}

--mb assets
this.enableIRSensorsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.enableFultonAlarmsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hideContainersMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hideAACannonsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hideAAGatlingsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hideTurretMgsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.hideMortarsMB={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--< ivar defs
this.langStrings={
  eng={
    enableFultonAlarmsMB="Enable asset alarms",
    enableIRSensorsMB="Enable IR sensors",
    hideContainersMB="Hide containers",
    hideAACannonsMB="Hide AA cannons",
    hideAAGatlingsMB="Hide AA gatlings",
    hideTurretMgsMB="Hide turret machineguns",
    hideMortarsMB="Hide mortars",
  },
  help={
    eng={
      enableFultonAlarmsMB="Enables anti fulton theft alarms on containers and AA guns. Only partially working, will only trigger alarm once.",
      enableIRSensorsMB="Enable IR sensor gates. Only partially working, will only trigger alarm once, and will only show one or no beam.",
    },
  },
}

function this.Init(missionTable)
  this.messageExecTable=nil

  if vars.missionCode~=30050 then
    return
  end

  --CULL
  --  if Ivars.enableFultonAlarmsMB:Is(0) and Ivars.enableIRSensorsMB:Is(0) then
  --    return
  --  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  this.InitCluster()
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  if vars.missionCode~=30050 then
    return
  end

  --CULL
  --  if Ivars.enableFultonAlarmsMB:Is(0) and Ivars.enableIRSensorsMB:Is(0) then
  --    return
  --  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  this.InitCluster()
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="BreakGimmick",func=this.OnBreakGimmick},
      {msg="BreakGimmickBurglarAlarm",func=this.OnBreakGimmickBurglarAlarm},
      {msg="BurglarAlarmTrap",func=function(bAlarmId,bAlarmHash,bAlarmDataSetName,gameObjectId)
        if Ivars.enableFultonAlarmsMB:Is(1) then
          this.RequestNoticeGimmick(bAlarmId,gameObjectId)
        end
      end},
      {msg="Fulton",func=function(gameObjectId,arg1,arg2,arg3)
        --TppTerminal.OnFultonMessage( gameObjectId, arg1, arg2, arg3 )
        mvars.fultonInfo=mvars.fultonInfo or {}
        mvars.fultonInfo[gameObjectId]={gameObjectId,arg1,arg2,arg3}
      end},
      {msg="FultonInfo",func=function(gameObjectId,fultonedPlayer)
        --TppTerminal.OnFultonInfoMessage( gameObjectId, fultonedPlayer )
        mvars.fultonInfo=mvars.fultonInfo or {}
        local fultonInfo=mvars.fultonInfo[gameObjectId]
        if fultonInfo==nil then
          InfCore.Log("### FultonInfo :: Not Fulton Success ")
          return
        end
        if Tpp.IsFultonContainer(gameObjectId) then
          if Ivars.enableFultonAlarmsMB:Is(1) then
            if Gimmick.CallBurglarAlarm(gameObjectId,this.burgularAlarmRange,this.burgularAlarmTime)==true then
              InfCore.Log("CallBurglarAlarm / Fulton")
              this.RequestNoticeGimmick(gameObjectId, fultonedPlayer)
            end
          end
        end
        if Tpp.IsGatlingGun(gameObjectId) then
          if Ivars.enableFultonAlarmsMB:Is(1) then
            if Gimmick.CallBurglarAlarm(gameObjectId,this.burgularAlarmRange,this.burgularAlarmTime)==true then
              InfCore.Log("CallBurglarAlarm / Fulton")
              this.RequestNoticeGimmick(gameObjectId,fultonedPlayer)
            end
          end
        end
        mvars.fultonInfo[gameObjectId]=nil
      end},
      {msg="FultonFailed",
        func=function(gameObjectId)
          if Tpp.IsFultonContainer(gameObjectId) or Tpp.IsGatlingGun(gameObjectId)then
            InfCore.Log("CallBurglarAlarm / FultonFailed ")
            if Gimmick.CallBurglarAlarm(gameObjectId,this.burgularAlarmRange,this.burgularAlarmTime)==true then
              this.RequestNoticeGimmick(gameObjectId,0)
            end
          end
        end
      },
      {msg="WarningGimmick",func=function(irSensorId,irHash,irDataSetName,gameObjectId)
        this.RequestNoticeGimmick(irSensorId,gameObjectId)
      end},
      {msg="SwitchGimmick",
        func=function(gameId,locatorS32,dataSetP32,switchFlag)
          local gimmickId=TppGimmick.GetGimmickID(gameId,locatorS32,dataSetP32)
          local connectPowerCutAreaTable=mvars.gim_connectPowerCutAreaTable[gimmickId]
          if connectPowerCutAreaTable then--tex is power gen
            local sourceGameId=0
            this.RequestNoticeGimmick(gimmickId,sourceGameId)--tex no effect
          end
        end
      },
    },
    MotherBaseStage={
      --{msg="MotherBaseCurrentClusterLoadStart",func=this.MotherBaseCurrentClusterLoadStart},
      {msg="MotherBaseCurrentClusterActivated",func=this.MotherBaseCurrentClusterActivated},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.MotherBaseCurrentClusterActivated(clusterId)
  this.InitCluster(clusterId)
end

function this.InitCluster(clusterId)
  if vars.missionCode~=30050 then
    return
  end

  --  if not Ivars.mbAdditionalNpcs:EnabledForMission() then
  --    return
  --  end

  clusterId=clusterId or MotherBaseStage.GetCurrentCluster()
  if this.debugModule then
    InfCore.Log("InfMBGimmick.InitCluster "..tostring(clusterId).." "..tostring(InfMain.CLUSTER_NAME[clusterId+1]))
  end

  local grade=TppLocation.GetMbStageClusterGrade(clusterId)
  --tex no plats on cluster
  if grade==0 then
    return
  end

  --tex mbqf,zoo
  if vars.missionCode~=30050 then
    grade=1
  end
  --zoo
  if vars.missionCode==30150 then
    clusterId=8
  end
  if vars.missionCode==30250 then
    clusterId=7
  end

  --
  if not mvars.mbItem_funcGetAssetTable then
    return
  end

  local layoutCode=vars.mbLayoutCode
  local dataSet=string.format("/Assets/tpp/level/location/mtbs/block_area/ly%03d/cl%02d/mtbs_ly%03d_cl%02d_item.fox2",layoutCode,clusterId,layoutCode,clusterId)
  local assetTable=mvars.mbItem_funcGetAssetTable(clusterId+1)
  if assetTable then
    if Ivars.hideContainersMB:Is(1) then
      for k,v in ipairs(assetTable.containers)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,v,dataSet,true)
        end
      end
    end
    if Ivars.hideAACannonsMB:Is(1) then
      for k,v in ipairs(assetTable.eastAAGs)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,v,dataSet,true)
        end
      end
    end
    if Ivars.hideAAGatlingsMB:Is(1) then
      for k,v in ipairs(assetTable.westAAGs)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,v,dataSet,true)
        end
      end
    end


    if Ivars.hideTurretMgsMB:Is(1) then
      for k,v in ipairs(assetTable.westTurrets)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN,v,dataSet,true)
        end
      end
      for k,v in ipairs(assetTable.eastTurrets)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN,v,dataSet,true)
        end
      end
    end

    if Ivars.hideMortarsMB:Is(1) then
      for k,v in ipairs(assetTable.mortars)do
        if type(v)=="string" then
          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_MORTAR,v,dataSet,true)
        end
      end
    end


    --tex forcing show is no go
    --      for k,v in ipairs(assetTable.irsensors)do
    --        if type(v)=="string" then
    --          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IR_SENSOR,v,dataSet,false)
    --        end
    --      end
    --      for k,v in ipairs(assetTable.stolenAlarms)do
    --        if type(v)=="string" then
    --          Gimmick.InvisibleGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,v,dataSet,false)
    --        end
    --      end
  end
end

this.OnBreakGimmick=function(gameId,locatorS32,dataSetPath32,attackerId)

end

this.OnBreakGimmickBurglarAlarm=function(attackerId)

end

function this.RequestNoticeGimmick(gimmickId,sourceGameId)
  InfCore.Log("########RequestNoticeGimmick########gimmickId::"..gimmickId.." sourceGameId::"..sourceGameId)
  local cp=GetGameObjectId(mtbs_enemy.cpNameDefine)
  local command={id="RequestNotice",type=0,targetId=gimmickId,sourceId=sourceGameId}
  SendCommand(cp,command)
end

return this
