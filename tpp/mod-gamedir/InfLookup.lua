-- InfLookup.lua
-- tex various script analysis, lookup-tables, printing functions
-- still some other stuff scttered around:
-- InfMenu.CpNameString

local this={}

--LOCAOPT
local InfLog=InfLog
local TppGameObject=TppGameObject
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local NULL_ID=GameObject.NULL_ID

--lookup-tables>
--tex from exe, don't know if anythings missing (as it commonly seems)
this.gameObjectStringToType={
  GAME_OBJECT_TYPE_PLAYER2=TppGameObject.GAME_OBJECT_TYPE_PLAYER2,
  GAME_OBJECT_TYPE_COMMAND_POST2=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2,
  GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2,
  GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2,
  GAME_OBJECT_TYPE_HOSTAGE_UNIQUE=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE,
  GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2,
  GAME_OBJECT_TYPE_HOSTAGE_KAZ=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_KAZ,
  GAME_OBJECT_TYPE_OCELOT2=TppGameObject.GAME_OBJECT_TYPE_OCELOT2,
  GAME_OBJECT_TYPE_HUEY2=TppGameObject.GAME_OBJECT_TYPE_HUEY2,
  GAME_OBJECT_TYPE_CODE_TALKER2=TppGameObject.GAME_OBJECT_TYPE_CODE_TALKER2,
  GAME_OBJECT_TYPE_SKULL_FACE2=TppGameObject.GAME_OBJECT_TYPE_SKULL_FACE2,
  GAME_OBJECT_TYPE_MANTIS2=TppGameObject.GAME_OBJECT_TYPE_MANTIS2,
  GAME_OBJECT_TYPE_BIRD2=TppGameObject.GAME_OBJECT_TYPE_BIRD2,
  GAME_OBJECT_TYPE_HORSE2=TppGameObject.GAME_OBJECT_TYPE_HORSE2,
  GAME_OBJECT_TYPE_HELI2=TppGameObject.GAME_OBJECT_TYPE_HELI2,
  GAME_OBJECT_TYPE_ENEMY_HELI=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI,
  GAME_OBJECT_TYPE_OTHER_HELI=TppGameObject.GAME_OBJECT_TYPE_OTHER_HELI,
  GAME_OBJECT_TYPE_OTHER_HELI2=TppGameObject.GAME_OBJECT_TYPE_OTHER_HELI2,
  GAME_OBJECT_TYPE_BUDDYQUIET2=TppGameObject.GAME_OBJECT_TYPE_BUDDYQUIET2,
  GAME_OBJECT_TYPE_BUDDYDOG2=TppGameObject.GAME_OBJECT_TYPE_BUDDYDOG2,
  GAME_OBJECT_TYPE_BUDDYPUPPY=TppGameObject.GAME_OBJECT_TYPE_BUDDYPUPPY,
  GAME_OBJECT_TYPE_SAHELAN2=TppGameObject.GAME_OBJECT_TYPE_SAHELAN2,
  GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2,
  GAME_OBJECT_TYPE_LIQUID2=TppGameObject.GAME_OBJECT_TYPE_LIQUID2,
  GAME_OBJECT_TYPE_VOLGIN2=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2,
  GAME_OBJECT_TYPE_BOSSQUIET2=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2,
  GAME_OBJECT_TYPE_UAV=TppGameObject.GAME_OBJECT_TYPE_UAV,
  GAME_OBJECT_TYPE_SECURITYCAMERA2=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2,
  GAME_OBJECT_TYPE_GOAT=TppGameObject.GAME_OBJECT_TYPE_GOAT,
  GAME_OBJECT_TYPE_NUBIAN=TppGameObject.GAME_OBJECT_TYPE_NUBIAN,
  GAME_OBJECT_TYPE_CRITTER_BIRD=TppGameObject.GAME_OBJECT_TYPE_CRITTER_BIRD,
  GAME_OBJECT_TYPE_STORK=TppGameObject.GAME_OBJECT_TYPE_STORK,
  GAME_OBJECT_TYPE_EAGLE=TppGameObject.GAME_OBJECT_TYPE_EAGLE,
  GAME_OBJECT_TYPE_RAT=TppGameObject.GAME_OBJECT_TYPE_RAT,
  GAME_OBJECT_TYPE_ZEBRA=TppGameObject.GAME_OBJECT_TYPE_ZEBRA,
  GAME_OBJECT_TYPE_WOLF=TppGameObject.GAME_OBJECT_TYPE_WOLF,
  GAME_OBJECT_TYPE_JACKAL=TppGameObject.GAME_OBJECT_TYPE_JACKAL,
  GAME_OBJECT_TYPE_BEAR=TppGameObject.GAME_OBJECT_TYPE_BEAR,
  GAME_OBJECT_TYPE_CORPSE=TppGameObject.GAME_OBJECT_TYPE_CORPSE,
  GAME_OBJECT_TYPE_MBQUIET=TppGameObject.GAME_OBJECT_TYPE_MBQUIET,
  GAME_OBJECT_TYPE_COMMON_HORSE2=TppGameObject.GAME_OBJECT_TYPE_COMMON_HORSE2,
  GAME_OBJECT_TYPE_HORSE2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_HORSE2_FOR_VR,
  GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR,
  GAME_OBJECT_TYPE_VOLGIN2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2_FOR_VR,
  GAME_OBJECT_TYPE_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2,
  GAME_OBJECT_TYPE_COMMON_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2,
  GAME_OBJECT_TYPE_BATTLEGEAR=TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR,
  GAME_OBJECT_TYPE_EXAMPLE=TppGameObject.GAME_OBJECT_TYPE_EXAMPLE,
  GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT=TppGameObject.GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT,
  GAME_OBJECT_TYPE_NOTICE_OBJECT=TppGameObject.GAME_OBJECT_TYPE_NOTICE_OBJECT,
  GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE,
  GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER=TppGameObject.GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER,
  GAME_OBJECT_TYPE_EQUIP_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_EQUIP_SYSTEM,
  GAME_OBJECT_TYPE_PICKABLE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PICKABLE_SYSTEM,
  GAME_OBJECT_TYPE_COLLECTION_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_COLLECTION_SYSTEM,
  GAME_OBJECT_TYPE_THROWING_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_THROWING_SYSTEM,
  GAME_OBJECT_TYPE_PLACED_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PLACED_SYSTEM,
  GAME_OBJECT_TYPE_SHELL_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_SHELL_SYSTEM,
  GAME_OBJECT_TYPE_BULLET_SYSTEM3=TppGameObject.GAME_OBJECT_TYPE_BULLET_SYSTEM3,
  GAME_OBJECT_TYPE_CASING_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_CASING_SYSTEM,
  GAME_OBJECT_TYPE_FULTON=TppGameObject.GAME_OBJECT_TYPE_FULTON,
  GAME_OBJECT_TYPE_BALLOON_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_BALLOON_SYSTEM,
  GAME_OBJECT_TYPE_PARACHUTE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PARACHUTE_SYSTEM,
  GAME_OBJECT_TYPE_SUPPLY_CBOX=TppGameObject.GAME_OBJECT_TYPE_SUPPLY_CBOX,
  GAME_OBJECT_TYPE_SUPPORT_ATTACK=TppGameObject.GAME_OBJECT_TYPE_SUPPORT_ATTACK,
  GAME_OBJECT_TYPE_RANGE_ATTACK=TppGameObject.GAME_OBJECT_TYPE_RANGE_ATTACK,
  GAME_OBJECT_TYPE_CBOX=TppGameObject.GAME_OBJECT_TYPE_CBOX,
  GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM,
  GAME_OBJECT_TYPE_DECOY_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_DECOY_SYSTEM,
  GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM,
  GAME_OBJECT_TYPE_DUNG_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_DUNG_SYSTEM,
  GAME_OBJECT_TYPE_MARKER2_LOCATOR=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR,
  GAME_OBJECT_TYPE_ESPIONAGE_RADIO=TppGameObject.GAME_OBJECT_TYPE_ESPIONAGE_RADIO,
  GAME_OBJECT_TYPE_MGO_ACTOR=TppGameObject.GAME_OBJECT_TYPE_MGO_ACTOR,
  GAME_OBJECT_TYPE_FOB_GAME_DAEMON=TppGameObject.GAME_OBJECT_TYPE_FOB_GAME_DAEMON,
  GAME_OBJECT_TYPE_SYSTEM_RECEIVER=TppGameObject.GAME_OBJECT_TYPE_SYSTEM_RECEIVER,
  GAME_OBJECT_TYPE_SEARCHLIGHT=TppGameObject.GAME_OBJECT_TYPE_SEARCHLIGHT,
  GAME_OBJECT_TYPE_FULTONABLE_CONTAINER=TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,
  GAME_OBJECT_TYPE_GARBAGEBOX=TppGameObject.GAME_OBJECT_TYPE_GARBAGEBOX,
  GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
  GAME_OBJECT_TYPE_GATLINGGUN=TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
  GAME_OBJECT_TYPE_MORTAR=TppGameObject.GAME_OBJECT_TYPE_MORTAR,
  GAME_OBJECT_TYPE_MACHINEGUN=TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN,
  GAME_OBJECT_TYPE_DOOR=TppGameObject.GAME_OBJECT_TYPE_DOOR,
  GAME_OBJECT_TYPE_WATCH_TOWER=TppGameObject.GAME_OBJECT_TYPE_WATCH_TOWER,
  GAME_OBJECT_TYPE_TOILET=TppGameObject.GAME_OBJECT_TYPE_TOILET,
  GAME_OBJECT_TYPE_ESPIONAGEBOX=TppGameObject.GAME_OBJECT_TYPE_ESPIONAGEBOX,
  GAME_OBJECT_TYPE_IR_SENSOR=TppGameObject.GAME_OBJECT_TYPE_IR_SENSOR,
  GAME_OBJECT_TYPE_EVENT_ANIMATION=TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,
  GAME_OBJECT_TYPE_BRIDGE=TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
  GAME_OBJECT_TYPE_WATER_TOWER=TppGameObject.GAME_OBJECT_TYPE_WATER_TOWER,
  GAME_OBJECT_TYPE_RADIO_CASSETTE=TppGameObject.GAME_OBJECT_TYPE_RADIO_CASSETTE,
  GAME_OBJECT_TYPE_POI_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_POI_SYSTEM,
  GAME_OBJECT_TYPE_SAMPLE_MANAGER=TppGameObject.GAME_OBJECT_TYPE_SAMPLE_MANAGER,
}
this.gameObjectTypeToString={}
--TABLESETUP
for k,v in pairs(this.gameObjectStringToType)do
  this.gameObjectTypeToString[v]=k
end

function this.TppGameObjectTypeIndexToName(typeIndex)
  return this.gameObjectTypeToString[typeIndex]
end

function this.GenerateNameList(prefix,num,list)
  local list=list or {}
  for i=0,num-1 do
    local name=string.format("%s%04d",prefix,i)
    table.insert(list,name)
  end
  return list
end

--TABLESETUP
this.jeepNames=this.GenerateNameList("veh_lv_",20)
this.truckNames=this.GenerateNameList("veh_trc_",10)

function this.GetObjectList()
  return InfMain.reserveSoldierNames
    --        local travelPlan="travelArea2_01"
    --         return InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]
    --return InfNPC.ene_wildCardInfo
    --return InfParasite.parasiteNames[InfParasite.parasiteType]
    --return InfLookup.truckNames
    --return InfLookup.jeepNames
    --return {TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
    --return TppReinforceBlock.REINFORCE_SOLDIER_NAMES
    --return InfInterrogation.interCpQuestSoldiers
    --return InfWalkerGear.walkerNames
    --return InfNPCHeli.heliList
end

function this.GetObjectInfoOrPos(index)
    local objectList=this.GetObjectList()

    if objectList==nil then
      return nil,"objectList nil"
    end

    if #objectList==0 then
      return nil,"objectList empty"
    end

    local objectName=objectList[index]
    if objectName==nil then
      return nil,"objectName==nil for index "..index,nil
    end
    local gameId=objectName
    if type(objectName)=="string" then
      gameId=GetGameObjectId(objectName)
    end
    if gameId==nil then
      return objectName,objectName.." nil"
    end
    if gameId==NULL_ID then
      return objectName,objectName.." NULL_ID"
    end

    local position=GameObject.SendCommand(gameId,{id="GetPosition"})
    if position==nil then
      return objectName,objectName.." nil for GetPosition"
    end
    
    position={position:GetX(),position:GetY(),position:GetZ()}
    
    return objectName,"",position
end

--tex there's no real lookup for this I've found
--there's probably faster tables (look in DefineSoldiers()) that have the cpId>soldierId, but this is nice for the soldiername,cpname
function this.ObjectNameForGameIdList(findId,list,objectType)
  for n,name in ipairs(list)do
    local gameId=NULL_ID
    if objectType then
      gameId=GetGameObjectId(objectType,name)
    else
      gameId=GetGameObjectId(name)
    end
    if gameId~=NULL_ID then
      if gameId==findId then
        return name
      end
    end
  end
end
--returns name or nil
function this.ObjectNameForGameId(findId)
  if mvars.ene_soldierIDList then
    for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do
      for soldierId,soldierName in pairs(soldierIds)do
        if soldierId==findId then
          local cpName=mvars.ene_cpList[cpId]
          return soldierName,cpName
        end
      end
    end
  end

  local objectNameLists={
    {TppReinforceBlock.REINFORCE_SOLDIER_NAMES,"TppSoldier2"},
    InfNPCHeli.heliNames.UTH,
    InfNPCHeli.heliNames.HP48,
    InfWalkerGear.walkerNames,
    this.jeepNames,
    this.truckNames,
  }
  for i,list in ipairs(objectNameLists)do
    local objectName
    if type(list[1])=="table" then
      objectName=this.ObjectNameForGameIdList(findId,list[1],list[2])
    else
      objectName=this.ObjectNameForGameIdList(findId,list)
    end
    if objectName then
      return objectName
    end
  end

  local enemyHeli="EnemyHeli"
  local gameId=GetGameObjectId(enemyHeli)
  if gameId~=NULL_ID then
    if gameId==findId then
      return enemyHeli
    end
  end

  return nil
end

function this.BuildTppDamageLookup()
  local tppDamageEnumToName={}
  for k,v in pairs(TppDamage)do
    if type(v)=="number" then
      tppDamageEnumToName[v]=k
    end
  end
  return tppDamageEnumToName
end

function this.TppDamageEnumToName(enum)
  return this.tppDamageEnumToName[enum]
end

--TABLESETUP
this.tppDamageEnumToName=this.BuildTppDamageLookup()

--tex returns string or nil
--isStrCode on guaranteed strcodes to add that code to unknowns (this function is also used in a blanket fashion in PrintOnMessage with potential non-strcodes)
function this.StrCode32ToString(strCode,isStrCode)
  if type(strCode)=="number" then
    --tex using InfLog since this is built up using Fox.StrCode32 replacement InfLog.StrCode32, since InfLog is loaded before lib modules
    local returnString=InfLog.str32ToString[strCode]
    if returnString==nil then
      returnString=TppDbgStr32.DEBUG_StrCode32ToString(strCode)
      if returnString then
        InfLog.str32ToString[strCode]=returnString--tex push back into InfLog str32ToString so I can dump that as a verified in-use dictionary
      end
    end
    if isStrCode and returnString==nil then
      InfLog.unknownStr32[strCode]=true
    end
    return returnString
  end
end

function this.DumpStrCodeTables()  
  InfLog.Add("InfLog.str32ToString")  
  --InfLog.PrintInspect(InfLog.str32ToString)
  
  local strings={}
  local strToCode={}
  for strCode,str in pairs(InfLog.str32ToString)do
    table.insert(strings,str)
    strToCode[str]=strCode
  end
  table.sort(strings)
  for i,str in ipairs(strings) do
    InfLog.Add(str.."="..strToCode[str])    
  end

  InfLog.Add("InfLog.unknownStr32")
  InfLog.PrintInspect(InfLog.unknownStr32)
end
--< lookup tables

function this.PrintOnMessage(sender,messageId,arg0,arg1,arg2,arg3)
  --InfLog.PCall(function(sender,messageId,arg0,arg1,arg2,arg3)--DEBUG
    local lookupFuncs={
      this.StrCode32ToString,
      this.ObjectNameForGameId,
      this.TppGameObjectTypeIndexToName,
      this.TppDamageEnumToName,
    }

  --tex TODO: messageprofile
  --{messageIdName,{arg0Name,arg0Lookup}...}

  local senderStr=this.StrCode32ToString(sender,true) or sender
  local messageIdStr=this.StrCode32ToString(messageId,true) or messageId
  local messageInfoString="OnMessage|sender: "..senderStr..", messageId: "..messageIdStr
  local hasArgs=false
  local argsString=""
  local args={arg0,arg1,arg2,arg3}
  for i,arg in ipairs(args)do
    local argPreStr="arg"..(i-1)..": "
    local argValue=""
    if arg~=nil then
      hasArgs=true

      if type(arg)=="number" then
        local lookupReturns={}--tex possible number/id collisions, so return all
        --tex GOTCHA too many collisions on low numbers, pretty arbitrary cut-off point though.
        if arg>10 then
          for i,Lookup in ipairs(lookupFuncs) do
            local lookupReturn=Lookup(arg)
            if lookupReturn then
              lookupReturns[#lookupReturns+1]=lookupReturn
            end
          end
        end
        if #lookupReturns==0 then
          lookupReturns[#lookupReturns+1]=arg
        end
        local addSeperator=#lookupReturns>1
        for i,lookupReturn in ipairs(lookupReturns) do
          if addSeperator and i>1 then
            argValue=argValue.."||"
          end
          argValue=argValue..lookupReturn
        end
        if #lookupReturns>1 then
          argValue=arg..":"..argValue
        end
      end

      --argValue=tostring(arg)--DEBUG

      argsString=argsString..argPreStr..argValue..", "
    end
  end
  if hasArgs then
    messageInfoString=messageInfoString..", "..argsString
  end
  InfLog.Add(messageInfoString)
  for i,arg in ipairs(args)do
    if arg and type(arg)=="table" then
      InfLog.Add("arg"..(i-1))
      InfLog.PrintInspect(arg)
    end
  end
  --end,sender,messageId,arg0,arg1,arg2,arg3)--DEBUG
end


return this
