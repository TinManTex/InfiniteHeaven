local this={}
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
function this.OnTrapMessage(trapS32,o,r)
  local e=o[trapS32]
  if not e then
    return
  end
  if r then
    mvars.order_box_currentEnterOrderBoxName=e
  else
    mvars.order_box_currentEnterOrderBoxName=nil
  end
end
function this.OnGroundMessage(e,e,e)
  mvars.order_box_onGroundCount=mvars.order_box_onGroundCount+1
  if mvars.order_box_onGroundCount>=mvars.order_box_orderBoxCount then
    mvars.order_box_isAllOnGround=true
  end
end
function this.ReserveMissionClearOnOrderBoxTrap(e)
  if e and svars.acceptMissionId>0 then
    mvars.mis_orderBoxName=e
    gvars.mis_orderBoxName=Fox.StrCode32(e)
    TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO,nextMissionId=svars.acceptMissionId}
  end
end
function this.OnInitializeOrderBoxBlock(orderBoxScript,unkP2)
  local _orderBoxScript=orderBoxScript
  local o=unkP2
  local scriptBlockId=ScriptBlock.GetCurrentScriptBlockId()
  local scriptBlockState=ScriptBlock.GetScriptBlockState(scriptBlockId)
  TppScriptBlock.ActivateScriptBlockState(scriptBlockId)
  mvars.order_box_script=_orderBoxScript
  mvars.orb_orderBoxMarkerEnabled=false
  mvars.order_box_gameObjectInfo={}
  mvars.order_box_orderBoxCount=#mvars.order_box_script.orderBoxList
  mvars.order_box_onGroundCount=0
  mvars.order_box_isAllOnGround=false
  function mvars.order_box_script.Messages()
    return Tpp.StrCode32Table{
      Trap={
        {msg="Enter",func=function(trap,gameId)
          this.OnTrapMessage(trap,o,true)
        end,
        option={isExecMissionPrepare=true}},
        {msg="Exit",func=function(trap,gameId)
          this.OnTrapMessage(trap,o,false)
        end,
        option={isExecMissionPrepare=true}}},
      GameObject={{msg="EspionageBoxGimmickOnGround",func=this.OnGroundMessage,option={isExecMissionPrepare=true}}}}
  end
  local function e()
    mvars.order_box_script.messageExecTable=Tpp.MakeMessageExecTable(mvars.order_box_script.Messages())
  end
  mvars.order_box_script.OnReload=e
  function mvars.order_box_script.OnMessage(i,t,n,r,o,s,a)
    Tpp.DoMessage(mvars.order_box_script.messageExecTable,TppMission.CheckMessageOption,i,t,n,r,o,s,a)
  end
  e()
end
function this.OnUpdateOrderBoxBlock(r,r)
  local scriptBlockId=ScriptBlock.GetCurrentScriptBlockId()
  local scriptBlockState=ScriptBlock.GetScriptBlockState(scriptBlockId)
  if scriptBlockState~=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    return
  end
  if not mvars.orb_orderBoxMarkerEnabled then
    TppUI.ShowAnnounceLog"updateMap"mvars.orb_orderBoxMarkerEnabled=true
  end
  local r=mvars.order_box_currentEnterOrderBoxName
  if(r and mvars.order_box_isAllOnGround)and(not mvars.order_box_didResereveMissionClear)then
    if TppSequence.IsMissionPrepareFinished()then
      this.ReserveMissionClearOnOrderBoxTrap(r)
      mvars.order_box_didResereveMissionClear=true
    end
  end
end
function this.OnTerminateOrderBoxBlock(r,e)
  mvars.order_box_script=nil
  mvars.orb_orderBoxMarkerEnabled=nil
  mvars.order_box_didResereveMissionClear=nil
  mvars.order_box_gameObjectInfo=nil
  mvars.order_box_orderBoxCount=nil
  mvars.order_box_onGroundCount=nil
  mvars.order_box_isAllOnGround=nil
  local r=ScriptBlock.GetCurrentScriptBlockId()
  TppScriptBlock.FinalizeScriptBlockState(r)
  if Tpp.IsTypeTable(e)then
    for r,e in pairs(e)do
      local e=GameObject.GetGameObjectId(e)
      if(e~=GameObject.NULL_ID)then
        TppUiCommand.UnRegisterIconUniqueInformation(e)
      end
    end
  end
end
return this
