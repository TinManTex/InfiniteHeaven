-- DOBUILD: 1
-- ssd Tpp.lua
InfInit=require"mod/core/InfInit"--tex here since can't add own internal scripts to ssd at the moment, and I don't think any earlier Script.LoadLoadlibraries are worth it
InfCore.LogFlow"Load Tpp.lua"--tex
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
local type=type
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local GAME_OBJECT_TYPE_PLAYER2=TppGameObject.GAME_OBJECT_TYPE_PLAYER2
local GAME_OBJECT_TYPE_COMMAND_POST2=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2
local GAME_OBJECT_TYPE_KAIJU=TppGameObject.GAME_OBJECT_TYPE_KAIJU
local GAME_OBJECT_TYPE_BOSS_1=TppGameObject.GAME_OBJECT_TYPE_BOSS_1
local GAME_OBJECT_TYPE_BOSS_2=TppGameObject.GAME_OBJECT_TYPE_BOSS_2
local GAME_OBJECT_TYPE_BOSS_3=TppGameObject.GAME_OBJECT_TYPE_BOSS_3
local GAME_OBJECT_TYPE_ZOMBIE=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local GAME_OBJECT_TYPE_HOSTAGE_UNIQUE=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE
local GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2
local GAME_OBJECT_TYPE_HELI2=TppGameObject.GAME_OBJECT_TYPE_HELI2
local GAME_OBJECT_TYPE_ENEMY_HELI=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI
local GAME_OBJECT_TYPE_HORSE2=TppGameObject.GAME_OBJECT_TYPE_HORSE2
local GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local GAME_OBJECT_TYPE_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2
local GAME_OBJECT_TYPE_COMMON_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2
local GAME_OBJECT_TYPE_VOLGIN2=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2
local GAME_OBJECT_TYPE_MARKER2_LOCATOR=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR
local GAME_OBJECT_TYPE_BOSSQUIET2=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local GAME_OBJECT_TYPE_SECURITYCAMERA2=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2
local GAME_OBJECT_TYPE_UAV=TppGameObject.GAME_OBJECT_TYPE_UAV
local PHASE_ALERT=TppGameObject.PHASE_ALERT
local NULL_ID=GameObject.NULL_ID
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor
this.requires={
  "/Assets/ssd/script/lib/TppDefine.lua",
  "/Assets/ssd/script/list/SsdStorySequenceList.lua",
  "/Assets/ssd/script/list/SsdStorySequenceRewardList.lua",
  "/Assets/ssd/script/list/SsdCrewList.lua",
  "/Assets/ssd/script/list/SsdRecipeList.lua",
  "/Assets/ssd/script/list/SsdMissionList.lua",
  "/Assets/ssd/script/list/SsdCreatureList.lua",
  "/Assets/ssd/script/list/SsdFastTravelPointList.lua",
  "/Assets/ssd/script/list/SsdWaterPumpList.lua",
  "/Assets/ssd/script/lib/TppMath.lua",
  "/Assets/ssd/script/lib/TppSave.lua",
  "/Assets/ssd/script/lib/TppLocation.lua",
  "/Assets/ssd/script/lib/TppSequence.lua",
  "/Assets/ssd/script/lib/TppWeather.lua",
  "/Assets/ssd/script/lib/TppDbgStr32.lua",
  "/Assets/ssd/script/lib/TppDebug.lua",
  "/Assets/ssd/script/lib/TppClock.lua",
  "/Assets/ssd/script/lib/TppUI.lua",
  "/Assets/ssd/script/lib/TppResult.lua",
  "/Assets/ssd/script/lib/TppSound.lua",
  "/Assets/ssd/script/lib/TppTerminal.lua",
  "/Assets/ssd/script/lib/TppMarker.lua",
  "/Assets/ssd/script/lib/TppRadio.lua",
  "/Assets/ssd/script/lib/TppPlayer.lua",
  "/Assets/ssd/script/lib/TppScriptBlock.lua",
  "/Assets/ssd/script/lib/TppMission.lua",
  "/Assets/ssd/script/lib/TppStory.lua",
  "/Assets/ssd/script/lib/TppDemo.lua",
  "/Assets/ssd/script/lib/TppCrew.lua",
  "/Assets/ssd/script/lib/TppEnemy.lua",
  "/Assets/ssd/script/lib/TppGimmick.lua",
  "/Assets/ssd/script/lib/TppMain.lua",
  "/Assets/ssd/script/lib/TppDemoBlock.lua",
  "/Assets/ssd/script/lib/TppAnimalBlock.lua",
  "/Assets/ssd/script/lib/TppCheckPoint.lua",
  "/Assets/ssd/script/lib/TppPackList.lua",
  "/Assets/ssd/script/lib/TppQuest.lua",
  "/Assets/ssd/script/lib/TppTrap.lua",
  "/Assets/ssd/script/lib/TppReward.lua",
  "/Assets/ssd/script/lib/TppReinforceBlock.lua",
  "/Assets/ssd/script/lib/TppEneFova.lua",
  "/Assets/ssd/script/lib/TppTelop.lua",
  "/Assets/ssd/script/lib/TppRatBird.lua",
  "/Assets/ssd/script/lib/TppMovie.lua",
  "/Assets/ssd/script/lib/TppAnimal.lua",
  "/Assets/ssd/script/lib/TppException.lua",
  "/Assets/ssd/script/lib/TppTutorial.lua",
  "/Assets/ssd/script/lib/TppRanking.lua",
  "/Assets/ssd/script/lib/TppTrophy.lua",
  "/Assets/ssd/script/lib/SsdFlagMission.lua",
  "/Assets/ssd/script/lib/SsdBaseDefense.lua",
  "/Assets/ssd/script/lib/SsdCreatureBlock.lua",
  "/Assets/ssd/script/lib/SsdRecipe.lua",
  "/Assets/ssd/script/lib/SsdFastTravel.lua",
  "/Assets/ssd/script/mission/flag/BaseFlagMission.lua",
  "/Assets/ssd/script/mission/quest/BaseQuest.lua",
  "/Assets/ssd/script/mission/quest/AnnihilationQuest.lua",
  "/Assets/ssd/script/mission/quest/DefenseQuest.lua",
  "/Assets/ssd/script/mission/quest/RescueQuest.lua",
  "/Assets/ssd/script/mission/quest/CollectionQuest.lua",
  "/Assets/ssd/script/mission/quest/AnimalQuest.lua",
  "/Assets/ssd/script/mission/quest/BossQuest.lua",
  "/Assets/ssd/script/mission/quest/ExtraDiggingQuest.lua",
  "/Assets/ssd/script/mission/quest/VehicleQuest.lua",
  "/Assets/ssd/script/mission/common/BaseMissionSequence.lua",
  "/Assets/ssd/script/mission/common/BaseMissionRadio.lua",
  "/Assets/ssd/script/mission/free/BaseFreeMissionSequence.lua",
  "/Assets/ssd/script/mission/free/BaseFreeMissionEnemy.lua",
  "/Assets/ssd/script/mission/free/BaseFreeMissionRadio.lua",
  "/Assets/ssd/script/mission/free/BaseFreeMissionDemo.lua",
  "/Assets/ssd/script/mission/coop/BaseCoopMissionSequence.lua",
  "/Assets/ssd/script/mission/coop/BaseCoopMissionEnemy.lua",
  "/Assets/ssd/script/mission/coop/BaseCoopMissionRadio.lua",
  "/Assets/ssd/script/mission/coop/BaseRescueMissionSequence.lua",--RETAILPATCH: 1.0.5.0>
  "/Assets/ssd/script/mission/coop/BaseRescueMissionEnemy.lua",
  "/Assets/ssd/script/mission/coop/BaseRescueMissionRadio.lua",--<
  "/Assets/ssd/script/mission/defense/BaseBaseDigging.lua"
}
function this.IsTypeFunc(e)
  return type(e)=="function"
end
local IsTypeFunc=this.IsTypeFunc
function this.IsTypeTable(e)
  return type(e)=="table"
end
local IsTypeTable=this.IsTypeTable
function this.IsTypeString(e)
  return type(e)=="string"
end
local IsTypeString=this.IsTypeString
function this.IsTypeNumber(e)
  return type(e)=="number"
end
local IsTypeNumber=this.IsTypeNumber

--NMC GOTCHA TppDefine.Enum indexed from 0, Tpp.Enum indexed from one. silly.
--GOTCHA this also adds to input table instead of giving new TODO review in light of this
function this.Enum(nameTable)
  if nameTable==nil then
    return
  end
  if#nameTable==0 then
    return nameTable
  end
  for n=1,#nameTable do
    nameTable[nameTable[n]]=n
  end
  return nameTable
end
function this.IsMaster()
  if TppGameSequence.IsMaster()then
    return true
  else
    if gvars and gvars.dbg_forceMaster then
      return true
    else
      return false
    end
  end
end
function this.IsQARelease()
  return(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)
end
function this.IsEditor()
  if(Fox.GetPlatformName()=="Windows")and Editor then
    return true
  end
  return false
end
function this.IsEditorNoLogin()
  if not this.IsEditor()then
    return false
  end
  if not TppServerManager.IsLoginKonami()then
    return true
  end
  return false
end
function this.SplitString(string,delim)
  local splitStringTable={}
  local splitIndex
  local splitString=string
  while true do
    splitIndex=string.find(splitString,delim)
    if(splitIndex==nil)then
      table.insert(splitStringTable,splitString)
      break
    else
      local subString=string.sub(splitString,0,splitIndex-1)
      table.insert(splitStringTable,subString)
      splitString=string.sub(splitString,splitIndex+1)
    end
  end
  return splitStringTable
end
function this.StrCode32Table(inTable)
  local strCode32Table={}
  for k,v in pairs(inTable)do
    local key=k
    if type(key)=="string"then
      key=StrCode32(key)
    end
    if type(v)=="table"then
      strCode32Table[key]=this.StrCode32Table(v)
    else
      strCode32Table[key]=v
    end
  end
  return strCode32Table
end
function this.ApendArray(destTable,sourceTable)
  for k,v in pairs(sourceTable)do
    destTable[#destTable+1]=v
  end
end
function this.MergeTable(table1,table2,unk3)
  local mergedTable=table1
  for k,v in pairs(table2)do
    if table1[k]==nil then
      mergedTable[k]=v
    else
      mergedTable[k]=v
    end
  end
  return mergedTable
end
function this.BfsPairs(r)
  local i,n,s={r},1,1
  local function a(t,e)
    local e,t=e,nil
    while true do
      e,t=next(i[n],e)
      if IsTypeTable(t)then
        s=s+1
        i[s]=t
      end
      if e then
        return e,t
      else
        n=n+1
        if n>s then
          return
        end
      end
    end
  end
  return a,r,nil
end
this._DEBUG_svars={}
this._DEBUG_gvars={}
--IN: messages (str32)table from various module .Messages() func
--OUT: messageExecTable[messageClassS32][messageNameS32].func=objectMessageFunc
--or messageExecTable[messageClassS32][messageNameS32].sender[senderId]=objectMessageFunc --tex NMC senderId is either str32 of original sender or gameId
--In most cases table is output to some <module>.messageExecTable
function this.MakeMessageExecTable(messagesS32)
  if messagesS32==nil then
    return
  end
  if next(messagesS32)==nil then
    return
  end
  local messageExecTable={}
  local s32_msg=StrCode32"msg"
  local s32_func=StrCode32"func"
  local s32_sender=StrCode32"sender"
  local s32_option=StrCode32"option"
  for messageClassS32,classMessages in pairs(messagesS32)do
    messageExecTable[messageClassS32]=messageExecTable[messageClassS32]or{}
    for i,messageInfo in pairs(classMessages)do--tex TODO: re analyse
      local messageNameS32,senderIds,classMessageFunc,options=i,nil,nil,nil
      if IsTypeFunc(messageInfo)then
        classMessageFunc=messageInfo
      elseif IsTypeTable(messageInfo)and IsTypeFunc(messageInfo[s32_func])then
        messageNameS32=StrCode32(messageInfo[s32_msg])
        local messageSenders={}
        if(type(messageInfo[s32_sender])=="string")or(type(messageInfo[s32_sender])=="number")then
          messageSenders[1]=messageInfo[s32_sender]
        elseif IsTypeTable(messageInfo[s32_sender])then
          messageSenders=messageInfo[s32_sender]
        end
        senderIds={}
        for k,senderId in pairs(messageSenders)do
          if type(senderId)=="string"then
            if messageClassS32==StrCode32"GameObject"then
              senderIds[k]=GetGameObjectId(senderId)
              --RETAILBUG msgSndr not defined, moot, no executing code, commented out anyway
              --              if msgSndr==NULL_ID then
              --              end
            else
              senderIds[k]=StrCode32(senderId)
            end
          elseif type(senderId)=="number"then
            senderIds[k]=senderId
          end
        end
        classMessageFunc=messageInfo[s32_func]options=messageInfo[s32_option]end
      if classMessageFunc then
        messageExecTable[messageClassS32][messageNameS32]=messageExecTable[messageClassS32][messageNameS32]or{}
        if next(senderIds)~=nil then
          for k,senderId in pairs(senderIds)do
            messageExecTable[messageClassS32][messageNameS32].sender=messageExecTable[messageClassS32][messageNameS32].sender or{}messageExecTable[messageClassS32][messageNameS32].senderOption=messageExecTable[messageClassS32][messageNameS32].senderOption or{}
            if messageExecTable[messageClassS32][messageNameS32].sender[senderId]then
            end
            messageExecTable[messageClassS32][messageNameS32].sender[senderId]=classMessageFunc
            if options and IsTypeTable(options)then
              messageExecTable[messageClassS32][messageNameS32].senderOption[senderId]=options
            end
          end
        else
          if messageExecTable[messageClassS32][messageNameS32].func then
          end
          messageExecTable[messageClassS32][messageNameS32].func=classMessageFunc
          if options and IsTypeTable(options)then
            messageExecTable[messageClassS32][messageNameS32].option=options
          end
        end
      end
    end
  end
  return messageExecTable
end
--tex NMC CheckMessageOption seems to always be TppMission.CheckMessageOption
function this.DoMessage(messageExecTable,CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if not messageExecTable then
    return
  end
  local classMessages=messageExecTable[sender]
  if not classMessages then
    return
  end
  local messageIdRecievers=classMessages[messageId]
  if not messageIdRecievers then
    return
  end
  local unkBool=true
  if InfCore.debugMode and Ivars.debugMessages:Get()==1 then--tex> wrap in pcall
    InfCore.PCall(this.DoMessageAct,messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText,unkBool)
  else--<
    this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText,unkBool)
  end
end
function this.DoMessageAct(messageIdRecievers,CheckMessageOption,arg0,arg1,arg2,arg3,strLogText)
  if messageIdRecievers.func then
    if CheckMessageOption(messageIdRecievers.option)then
      messageIdRecievers.func(arg0,arg1,arg2,arg3)
    end
  end
  local senders=messageIdRecievers.sender
  if senders and senders[arg0]then
    if CheckMessageOption(messageIdRecievers.senderOption[arg0])then
      senders[arg0](arg0,arg1,arg2,arg3)
    end
  end
end
function this.GetRotationY(rotQuat)
  if not rotQuat then
    return
  end
  if(type(rotQuat.Rotate)=="function")then
    local rotVec=rotQuat:Rotate(Vector3(0,0,1))
    local rotRadian=foxmath.Atan2(rotVec:GetX(),rotVec:GetZ())
    return TppMath.RadianToDegree(rotRadian)
  end
end
function this.GetLocator(identifier,key)
  local pos,rotQuat=this.GetLocatorByTransform(identifier,key)
  if pos~=nil then
    return TppMath.Vector3toTable(pos),this.GetRotationY(rotQuat)
  else
    return nil
  end
end
function this.GetLocatorByTransform(identifier,key)
  local transFormData=this.GetDataWithIdentifier(identifier,key,"TransformData")
  if transFormData==nil then
    return
  end
  local worldTransform=transFormData.worldTransform
  return worldTransform.translation,worldTransform.rotQuat
end
function this.GetDataWithIdentifier(identifier,key,typeName)
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  --GOTCHA: NULL seems to be a valid return, likely used as SQL NULL - https://www.exasol.com/support/browse/SOL-129
  --either way the game relies on this value in a couple of calls, but this makes me worried with stuff like above testing for this function returning nil
  if data==NULL then
    return
  end
  if(data:IsKindOf(typeName)==false)then
    return
  end
  return data
end
function this.GetDataBodyWithIdentifier(identifier,key,typeName)
  local dataBody=DataIdentifier.GetDataBodyWithIdentifier(identifier,key)
  if(dataBody.data==nil)then
    return
  end
  if(dataBody.data:IsKindOf(typeName)==false)then
    return
  end
  return dataBody
end
function this.SetGameStatus(status)
  if not IsTypeTable(status)then
    return
  end
  local enable=status.enable
  local scriptName=status.scriptName
  local target=status.target
  local except=status.except
  if enable==nil then
    return
  end
  if target=="all"then
    target={}
    for statusName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      target[statusName]=statusType
    end
    for statusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      target[statusName]=statusType
    end
  elseif IsTypeTable(target)then
    target=target
  else
    return
  end
  if IsTypeTable(except)then
    for statusName,set in pairs(except)do
      target[statusName]=set
    end
  end
  if enable then
    for statusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      if target[statusName]then
        TppGameStatus.Reset(scriptName,statusName)
      end
    end
    for statusName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local status=target[statusName]
      local ui_unsetUiSetting=mvars.ui_unsetUiSetting
      if IsTypeTable(ui_unsetUiSetting)and ui_unsetUiSetting[statusName]then
        TppUiStatusManager.UnsetStatus(statusName,ui_unsetUiSetting[statusName])
      else
        if status then
          TppUiStatusManager.ClearStatus(statusName)
        end
      end
    end
  else
    for statusName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
      local status=target[statusName]
      if status then
        TppUiStatusManager.SetStatus(statusName,status)
      else
        TppUiStatusManager.ClearStatus(statusName)
      end
    end
    for statusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
      local status=target[statusName]
      if status then
        TppGameStatus.Set(scriptName,statusName)
      end
    end
  end
end
function this.GetAllDisableGameStatusTable()
  local statusTable={}
  for statusName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    statusTable[statusName]=false
  end
  for statusName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    statusTable[statusName]=false
  end
  return statusTable
end
function this.GetHelicopterStartExceptGameStatus()
  local status={}
  status.EquipPanel=false
  status.AnnounceLog=false
  status.HeadMarker=false
  status.WorldMarker=false
  return status
end
local function IsGameObjectType(gameObject,checkType)
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
function this.IsPlayer(gameId)
  return IsGameObjectType(gameId,GAME_OBJECT_TYPE_PLAYER2)
end
function this.IsLocalPlayer(playerIndex)
  if playerIndex==PlayerInfo.GetLocalPlayerIndex()then
    return true
  else
    return false
  end
end
function this.IsCommandPost(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_COMMAND_POST2)
end
function this.IsKaiju(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_KAIJU)
end
function this.IsBoss1(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_BOSS_1)
end
function this.IsBoss2(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_BOSS_2)
end
function this.IsBoss3(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_BOSS_3)
end
function this.IsZombie(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_ZOMBIE)
end
function this.IsSoldier(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_SOLDIER2)
end
function this.IsHostage(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.HOSTAGE_GM_TYPE[e]
end
function this.IsVolgin(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_VOLGIN2)
end
function this.IsHelicopter(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_HELI2)
end
function this.IsEnemyHelicopter(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_ENEMY_HELI)
end
function this.IsHorse(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_HORSE2)
end
function this.IsVehicle(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_VEHICLE)
end
function this.IsPlayerWalkerGear(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_WALKERGEAR2)
end
function this.IsEnemyWalkerGear(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_COMMON_WALKERGEAR2)
end
function this.IsUav(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_UAV)
end
function this.IsFultonContainer(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER)
end
function this.IsMortar(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_MORTAR)
end
function this.IsGatlingGun(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN)
end
function this.IsMachineGun(e)
  return IsGameObjectType(e,TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN)
end
function this.IsFultonableGimmick(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.FULTONABLE_GIMMICK_TYPE[e]
end
function this.GetBuddyTypeFromGameObjectId(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.BUDDY_GM_TYPE_TO_BUDDY_TYPE[e]
end
function this.IsMarkerLocator(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_MARKER2_LOCATOR)
end
function this.IsAnimal(e)
  if e==nil then
    return
  end
  if e==NULL_ID then
    return
  end
  local e=GetTypeIndex(e)
  return TppDefine.ANIMAL_GAMEOBJECT_TYPE[e]
end
function this.IsBossQuiet(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_BOSSQUIET2)
end
function this.IsParasiteSquad(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_PARASITE2)
end
function this.IsSecurityCamera(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_SECURITYCAMERA2)
end
function this.IsGunCamera(n)
  if n==NULL_ID then
    return false
  end
  local t={id="IsGunCamera"}
  local e=false
  e=GameObject.SendCommand(n,t)
  return e
end
function this.IsUAV(e)
  return IsGameObjectType(e,GAME_OBJECT_TYPE_UAV)
end
function this.IncrementPlayData(gvarName)
  if gvars[gvarName]==nil then
    return
  end
  if gvars[gvarName]<TppDefine.MAX_32BIT_UINT then
    gvars[gvarName]=gvars[gvarName]+1
  end
end
function this.IsNotAlert()
  if vars.playerPhase<PHASE_ALERT then
    return true
  else
    return false
  end
end
function this.IsPlayerStatusNormal()
  local vars=vars
  if vars.playerLife>0 and vars.playerStamina>0 then
    return true
  else
    return false
  end
end
function this.AreaToIndices(areaExtents)
  local xMin,yMin,xMax,yMax=areaExtents[1],areaExtents[2],areaExtents[3],areaExtents[4]
  local areaIndicies={}
  for x=xMin,xMax do
    for y=yMin,yMax do
      table.insert(areaIndicies,{x,y})
    end
  end
  return areaIndicies
end
function this.CheckBlockArea(areaExtents,blockIndexX,blockIndexY)
  local xMin,yMin,xMax,yMax=areaExtents[1],areaExtents[2],areaExtents[3],areaExtents[4]
  if(((blockIndexX>=xMin)and(blockIndexX<=xMax))and(blockIndexY>=yMin))and(blockIndexY<=yMax)then
    return true
  end
  return false
end
function this.FillBlockArea(e,r,s,n,t,i)
  for n=r,n do
    e[n]=e[n]or{}
    for t=s,t do
      e[n][t]=i
    end
  end
end
function this.GetCurrentStageSmallBlockIndex()
  local halfBlockSize=2
  local x,y=StageBlock.GetCurrentMinimumSmallBlockIndex()
  return(x+halfBlockSize),(y+halfBlockSize)
end
function this.IsLoadedSmallBlock(blockIndexX,blockIndexY)
  local blockSize=4
  local minX,minY=StageBlock.GetCurrentMinimumSmallBlockIndex()
  local maxX=minX+blockSize
  local maxY=minY+blockSize
  return((minX<=blockIndexX and blockIndexX<=maxX)and minY<=blockIndexY)and blockIndexY<=maxY
end
function this.IsLoadedLargeBlock(blockName)
  local checkBlockNameStr32=StrCode32(blockName)
  local largeBlocks=StageBlock.GetLoadedLargeBlocks(0)
  for i,blockNameStr32 in pairs(largeBlocks)do
    if blockNameStr32==checkBlockNameStr32 then
      return true
    end
  end
  return false
end
function this.GetLoadedLargeBlock()
  local largeBlocks=StageBlock.GetLoadedLargeBlocks(0)
  for i,blockNameStr32 in pairs(largeBlocks)do
    return blockNameStr32
  end
  return nil
end
--NMC is just GetChunkIndex in TPP, guess they added concurrent chunk installation or something
function this.GetChunkIndexList(locationId,missionCode)
  local chunkIndexList={}
  if missionCode and TppMission.IsMultiPlayMission(missionCode)then
    chunkIndexList={Chunk.INDEX_AFGH,Chunk.INDEX_MAFR}
  else
    local chunkIndex=TppDefine.LOCATION_CHUNK_INDEX_TABLE[locationId]
    if chunkIndex==nil then
      if not TppGameSequence.IsMaster()then
        Fox.Hungup()
      end
    else
      chunkIndexList={chunkIndex}
    end
  end
  return chunkIndexList
end
function this.StartWaitChunkInstallation(chunkIndex)
  Chunk.PrefetchChunk(chunkIndex)
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  this.ClearChunkInstallPopupUpdateTime()
end
local timeIncrement=1
local chunkInstallPopupUpdateTime=0
--NMC p1 was chunkId, now table of
function this.ShowChunkInstallingPopup(chunkIds,useOneCancelButtonPopup)
  local frameTime=Time.GetFrameTime()
  chunkInstallPopupUpdateTime=chunkInstallPopupUpdateTime-frameTime
  if chunkInstallPopupUpdateTime>0 then
    return
  end
  chunkInstallPopupUpdateTime=chunkInstallPopupUpdateTime+timeIncrement
  if chunkInstallPopupUpdateTime<0 then
    chunkInstallPopupUpdateTime=0
  end
  local platform=Fox.GetPlatformName()
  local totalInstallEta=0
  for i,chunkId in ipairs(chunkIds)do
    local installEta=Chunk.GetChunkInstallationEta(chunkId)
    if installEta then
      totalInstallEta=totalInstallEta+installEta
    end
  end
  if totalInstallEta and platform=="PS4"then
    if totalInstallEta>86400 then
      totalInstallEta=86400
    end
    TppUiCommand.SetErrorPopupParam(totalInstallEta)
  end
  local totalInstallRate=0
  for t,chunkId in ipairs(chunkIds)do
    local installRate=Chunk.GetChunkInstallationRate(chunkId)
    if installRate then
      totalInstallRate=totalInstallRate+installRate
    end
  end
  totalInstallRate=totalInstallRate/#chunkIds
  if totalInstallRate and platform=="XboxOne"then
    TppUiCommand.SetErrorPopupParam(totalInstallRate*1e4,"None",2)
  end
  local popupType
  if useOneCancelButtonPopup then
    popupType=Popup.TYPE_ONE_CANCEL_BUTTON
  else
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
  end
  TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLING,popupType)
end
function this.ClearChunkInstallPopupUpdateTime()
  chunkInstallPopupUpdateTime=0
end
function this.GetFormatedStorageSizePopupParam(neededSpace)
  local toKb=1024
  local toMb=1024*toKb
  local toGb=1024*toMb
  local gb,mb,kb=neededSpace/toGb,neededSpace/toMb,neededSpace/toKb
  local size=0
  local unitLetter=""
  if gb>=1 then
    size=gb*100
    unitLetter="G"
  elseif mb>=1 then
    size=mb*100
    unitLetter="M"
  elseif kb>=1 then
    size=kb*100
    unitLetter="K"
  else
    return neededSpace,"",0
  end
  local sizeValue=math.ceil(size)
  return sizeValue,unitLetter,2
end
if DebugText then
  this.DEBUG_debugDlcTypeTextTable={
    [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]="PATCH_DLC_TYPE_MGO_DATA",
    [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]="PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA"
  }
end
function this.PatchDlcCheckCoroutine(OnPatchExist,OnPatchNotExist,skipDlcTypeCheck,dlcType)
  if dlcType==nil then
    dlcType=PatchDlc.PATCH_DLC_TYPE_MGO_DATA
  end
  local validTypes={
    [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=true,
    [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=true
  }
  if not validTypes[dlcType]then
    Fox.Hungup"Invalid dlc type."
    return false
  end
  local DebugText=DebugText
  local function DebugPrint(message)
    if DebugText then
      local dlcTypeText=this.DEBUG_debugDlcTypeTextTable[dlcType]or"PATCH_DLC_TYPE_MGO_DATA"
      DebugText.Print(DebugText.NewContext(),"Tpp.PatchDlcCheckCoroutine: dlcType = "..(tostring(dlcTypeText)..(", "..tostring(message))))
    end
  end
  local function ClosePopupYield()
    if TppUiCommand.IsShowPopup()then
      TppUiCommand.ErasePopup()
      while TppUiCommand.IsShowPopup()do
        DebugPrint"waiting popup closed..."
        coroutine.yield()
      end
    end
  end
  local function YeildWhileSaving()
    while TppSave.IsSaving()do
      DebugPrint"waiting saving end..."
      coroutine.yield()
    end
  end
  YeildWhileSaving()
  PatchDlc.StartCheckingPatchDlc(dlcType)
  if PatchDlc.IsCheckingPatchDlc()then
    if not skipDlcTypeCheck then
      ClosePopupYield()
      local errorIds={
        [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]=5100,
        [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]=5150
      }
      local errorId=errorIds[dlcType]
      TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
      TppUiCommand.ShowErrorPopup(errorId)
    end
    while PatchDlc.IsCheckingPatchDlc()do
      DebugPrint"waiting checking PatchDlc end..."
      coroutine.yield()
      TppUI.ShowAccessIconContinue()
    end
  end
  ClosePopupYield()
  if PatchDlc.DoesExistPatchDlc(dlcType)then
    if OnPatchExist then
      OnPatchExist()
    end
    return true
  else
    if OnPatchNotExist then
      OnPatchNotExist()
    end
    return false
  end
end
function this.IsPatchDlcValidPlatform(dlcId)
  local platformsForDlc={
    [PatchDlc.PATCH_DLC_TYPE_MGO_DATA]={PS3=true,PS4=true},
    [PatchDlc.PATCH_DLC_TYPE_TPP_COMPATIBILITY_DATA]={Xbox360=true,PS3=true,PS4=true}
  }
  local platforms=platformsForDlc[dlcId]
  if not platforms then
    Fox.Hungup"Invalid dlc type."return false
  end
  local platformName=Fox.GetPlatformName()
  if platforms[platformName]then
    return true
  else
    return false
  end
end
function this.ClearDidCancelPatchDlcDownloadRequest()
  if(vars.didCancelPatchDlcDownloadRequest==1)then
    vars.didCancelPatchDlcDownloadRequest=0
    vars.isPersonalDirty=1
    TppSave.CheckAndSavePersonalData()
  end
end
function this.MergeMessageTable(table1,table2)
  if not table1 then
    table1={}
  end
  for k,v in pairs(table2)do
    if not table1[k]then
      table1[k]={}
    end
    for k2,v2 in ipairs(v)do
      table.insert(table1[k],v2)
    end
  end
  return table1
end
function this.IsBaseLoaded()
  return this.IsLoadedSmallBlock(129,150)
end
function this.DEBUG_DunmpBlockArea(s,t,n)
  local e="       "
  for n=1,n do
    e=e..string.format("%02d,",n)
  end
  for t=1,t do
    local e=""
    for n=1,n do
      e=e..string.format("%02d,",s[t][n])
    end
  end
end
function this.DEBUG_DumpTable(s,n)
  if n==nil then
  end
  if(type(s)~="table")then
    return
  end
  local i=""if n then
    for e=0,n do
      i=i.." "
    end
  end
  for i,s in pairs(s)do
    if type(s)=="table"then
      local n=n or 0
      n=n+1
      this.DEBUG_DumpTable(s,n)
    else
      if type(s)=="number"then
      end
    end
  end
end
function this.DEBUG_Where(stackLevel)
  local stackInfo=debug.getinfo(stackLevel+1)
  if stackInfo then
    return stackInfo.short_src..(":"..stackInfo.currentline)
  end
  return"(unknown)"
end
function this.DEBUG_StrCode32ToString(str32string)
  if str32string~=nil then
    local originalString
    if(TppDbgStr32)then
      originalString=TppDbgStr32.DEBUG_StrCode32ToString(str32string)
    end
    if originalString then
      return originalString
    else
      if type(str32string)=="string"then
      end
      return tostring(str32string)
    end
  else
    return"nil"
  end
end
function this.DEBUG_Fatal(e,e)
end
function this.DEBUG_SetPreference(entityName,property,value)
  local entity=Preference.GetPreferenceEntity(entityName)
  if(entity==nil)then
    return
  end
  if(entity[property]==nil)then
    return
  end
  Command.SetProperty{entity=entity,property=property,value=value}
end
--NMC _requirelist adds a number of calls from TppMain on the libs
--DeclareSVars, Init, OnReload, OnChangeSVars, OnMessage
this._requireList={}
do
  for t,libPath in ipairs(this.requires)do
    local split=this.SplitString(libPath,"/")
    local libName=string.sub(split[#split],1,#split[#split]-4)
    local disallow={TppMain=true,TppDemoBlock=true,mafr_luxury_block_list=true}
    if not disallow[libName]then
      this._requireList[#this._requireList+1]=libName
    end
  end
end
InfCore.LogFlow"Tpp.lua done"--tex
return this
