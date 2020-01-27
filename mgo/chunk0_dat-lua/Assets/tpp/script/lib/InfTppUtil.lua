-- DOBUILD: 1
-- DEBUGNOW strip down to only needed
--InfTppUtil.lua
-- utility function dumping ground
-- stuff that doesnt have any dependancies to tpp can go in InfUtil
local this={}

local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex

--tex adds game object names to another table, with a not NULL_ID check
function this.ResetObjectPool(objectType,objectNames)
  local pool={}
  for i=1,#objectNames do
    local objectName=objectNames[i]
    local gameId=GetGameObjectId(objectType,objectName)
    if gameId==NULL_ID then
      InfCore.Log("ResetObjectPool: "..objectName.."==NULL_ID")--DEBUG
    else
      pool[#pool+1]=objectName
    end
  end
  return pool
end

--tex just from Tpp.IsGameObjectType, don't want to change it from local
function this.IsGameObjectType(gameObject,checkType)
  if gameObject==nil then
    return
  end
  if gameObject==NULL_ID then
    return
  end
  local typeIndex=GetTypeIndex(gameObject)
  if typeIndex==checkType then
    return true
  else
    return false
  end
end


--DEBUG
--tex loops at 512
--    local count=1100
--    local objectType="TppSoldier2"
--    for index=0,count-1 do
--      local gameId=GameObject.GetGameObjectIdByIndex(objectType,index)
--      --tex GetGameObjectIdByIndex errors on index > instance count: 'instance index range error. index n is larger than maxInstanceCount n.'
--      if gameId==NULL_ID then
--        --tex shouldnt happen
--        InfCore.Log("object index "..index.." ==NULL_ID")
--      else
--        local name=InfLookup.ObjectNameForGameId(gameId)
--        InfCore.Log("Soldier index "..index..": gameId:"..gameId.." name:"..tostring(name))
--        --tex return an 'instance index range error. index <GetGameObjectIdByIndex index> is larger than maxInstanceCount <instance count>.'
--        --which makes little sense since the gameId is the same/is not the index.
--        --errors/non errors seem to loop too (getting out of sync with the actual inputted index)
--        --ex:
----        |765.58408987113|Soldier index 842: gameId:1354 name:nil << tex fine even though index is over instance count
----        |765.58408987113|ERROR:C:/GamesSD/MGS_TPP/mod/InfMenuCommands.lua:770: instance index range error. index 330 is larger than maxInstanceCount 330. << not even reporting correct index
----        |765.58408987113|Soldier index 843: gameId:1355 name:nil
--        some other commands seem to be less safe and will hang or crash the game past max index
--        so will have to either be dead accurate with the max index you supply, reply on GetPosition as a canary/break on error for those gameobjects that support it
--        local pos=InfCore.PCall(function()GameObject.SendCommand(gameId,{id="GetPosition"})end)
--      end
--    end

--GOTCHA: there's some funkyness to GetGameObjectIdByIndex.
--GetMaxInstanceCount only works on a couple of gameobjects, hostages and walker gears (more frustrating kjp inconsistancy)
--GetGameObjectIdByIndex itself doesn't seem to care about inputting index > instance count, it will loop the returned gameobject eturning the same gameobjectids
--but running GameObject.SendCommand on a gameid from an index > instance count will return an 'instance index range error. index <GetGameObjectIdByIndex> is larger than maxInstanceCount <instance count>.'
--which doesn't really make sense, it suggests that the gameid has the index, even though on inspection it seems exactly the same/repeated < index gameid
--and it's only for some commands, others will hang or crash the game (again, this wouldn't be an issue if GetGameObjectIdByIndex didn't have a (seeminly) unsafe implmentation.
function this.RunOnAllObjects(objectType,instanceCount,RunFunc)
  local count=GameObject.SendCommand({type=objectType},{id="GetMaxInstanceCount"})
  InfCore.Log(objectType.." maxInstanceCount:"..tostring(count))--DEBUG
  if count==nil then
    count=instanceCount--SYNC soldier max instance/totalCount
  end
  if count and count>0 then
    for index=0,count-1 do
      local gameId=GameObject.GetGameObjectIdByIndex(objectType,index)
      --tex GetGameObjectIdByIndex errors on index > instance count: 'instance index range error. index n is larger than maxInstanceCount n.'
      if gameId==NULL_ID then
        --tex shouldnt happen
        InfCore.Log("object index "..index.." ==NULL_ID")
      else
        local success,ret=pcall(RunFunc,gameId,index)
        if not success then
          InfCore.Log("RunOnAllObjects GetGameObjectIdByIndex > instance count at index "..index..", breaking")
          break
        end
      end
    end
  end
end

function this.IsDemoPlaying()
  return DemoDaemon.IsDemoPaused() or DemoDaemon.IsDemoPlaying() or DemoDaemon.GetPlayingDemoId()
end

return this