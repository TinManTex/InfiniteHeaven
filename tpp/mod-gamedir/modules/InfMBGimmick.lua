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

function this.Init(missionTable)
  this.messageExecTable=nil

  if vars.missionCode~=30050 then
    return
  end
  
  if Ivars.enableFultonAlarmsMB:Is(0) and Ivars.enableIRSensorsMB:Is(0) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  if vars.missionCode~=30050 then
    return
  end
  
  if Ivars.enableFultonAlarmsMB:Is(0) and Ivars.enableIRSensorsMB:Is(0) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
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
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

this.OnBreakGimmick=function(gameObjectId,locatorNameHash,dataSetNameHash,AttackerId)

end

this.OnBreakGimmickBurglarAlarm=function(attackerId)

end

function this.RequestNoticeGimmick(gimmickId,playerId)
  InfCore.Log("########RequestNoticeGimmick########gimmickId::"..gimmickId.." playerId::"..playerId)
  local cp=GetGameObjectId(mtbs_enemy.cpNameDefine)
  local command={id="RequestNotice",type=0,targetId=gimmickId,sourceId=playerId}
  SendCommand(cp,command)
end

return this
