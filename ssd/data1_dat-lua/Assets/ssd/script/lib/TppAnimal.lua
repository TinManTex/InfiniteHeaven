local this={}
local a=Fox.StrCode32
local n=Tpp.IsTypeFunc
local n=Tpp.IsTypeTable
local n=Tpp.IsTypeString
local n=Tpp.IsTypeNumber
local d=GameObject.GetGameObjectId
local n=GameObject.GetGameObjectIdByIndex
local n=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local n=GameObject.NULL_ID
local t=GameObject.SendCommand
local t=Tpp.DEBUG_StrCode32ToString
this.AnimalExtraId={UNIQUE_ANIMAL_00=TppAnimalId.COUNT+0,UNIQUE_ANIMAL_01=TppAnimalId.COUNT+1,UNIQUE_ANIMAL_02=TppAnimalId.COUNT+2,UNIQUE_ANIMAL_03=TppAnimalId.COUNT+3}
this.AnimalIdTable={}
this.AnimalNpcTypeTable={[a"Bear"]="SsdBear",[a"KashmirBear"]="SsdKashmirBear",[a"Wolf"]="SsdWolf",[a"Jackal"]="SsdJackal",[a"Lycaon"]="SsdLycaon",[a"Anubis"]="SsdAnubis"}
function this.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="NpcActivated",func=this.SetAnimalLevel,option={isExecDemoPlaying=true,isExecMissionPrepare=true,isExecFastTravel=true,isExecMissionClear=true,isExecGameOver=true}}}}
end
function this.OnAllocate(e)
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  mvars.ani_questTargetList={}
  mvars.ani_questGameObjectIdList={}
  mvars.ani_isQuestSetup=false
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(a,n,t,d,i,s,l)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,a,n,t,d,i,s,l)
end
function this.GetDataBaseIdFromAnimalId(n)
  if n<TppAnimalId.COUNT then
    return TppAnimalSystem.GetDataBaseIdFromAnimalId(n)
  else
    return this.AnimalIdTable[n]
  end
end
function this.SetEnabled(e,t,a)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetEnabled",name=t,enabled=a}
  GameObject.SendCommand(e,n)
end
function this.SetRoute(e,t,a)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetRoute",name=t,route=a}
  GameObject.SendCommand(e,n)
end
function this.SetHerdRoute(e,t,a)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetHerdEnabledCommand",type="Route",name=t,instanceIndex=0,route=a}
  GameObject.SendCommand(e,n)
end
function this.SetKind(e,t,a)
  if a==nil then
    return
  end
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetKind",name=t,fv2Index=a}
  GameObject.SendCommand(e,n)
end
function this.SetFova(e,a,d,t)
  local i={type=e,index=0}
  if i==n then
    return
  end
  local e=nil
  if t==nil then
    e={id="SetFovaInfo",name=a,color=d,isMale=true,isSetAll=true}
  else
    e={id="SetFovaInfo",name=a,seed=t}
  end
  GameObject.SendCommand(i,e)
end
function this.SetNotice(e,a,t)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetNoticeEnabled",name=a,enabled=t}
  GameObject.SendCommand(e,n)
end
function this.SetIgnoreNotice(a,t,e)
  local a={type=a,index=0}
  if a==n then
    return
  end
  local e={id="SetIgnoreNotice",isPlayer=e,isSoldier=e}
  GameObject.SendCommand(a,e)
end
function this.SetSleep(e,t,a)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetStatus",status="Sleep",set=a}
  GameObject.SendCommand(e,n)
end
function this.SetAnimalId(e,t,a)
  local e={type=e,index=0}
  if e==n then
    return
  end
  local n={id="SetAnimalId",name=t,animalId=a}
  GameObject.SendCommand(e,n)
end
function this.SetBird(e)
  for n,e in ipairs(e)do
    local n={type=e.birdType,index=0}
    local a={id="SetEnabled",name=e.name,birdIndex=0,enabled=true}
    GameObject.SendCommand(n,a)
    if(e.center and e.radius)and e.height then
      local a={id="ChangeFlyingZone",name=e.name,center=e.center,radius=e.radius,height=e.height}
      GameObject.SendCommand(n,a)
      local a=nil
      if e.ground then
        a={id="SetLandingPoint",birdIndex=0,name=e.name,groundPos=e.ground}
        GameObject.SendCommand(n,a)
      elseif e.perch then
        a={id="SetLandingPoint",birdIndex=0,name=e.name,perchPos=e.perch}
        GameObject.SendCommand(n,a)
      end
      local e={id="SetAutoLanding",name=e.name}
      GameObject.SendCommand(n,e)
    end
  end
end
function this.GetPackFileListFromInstanceInfo(n,t)
  local a={}
  if Tpp.IsTypeTable(t)then
    a=t
  else
    table.insert(a,t)
  end
  for t,a in ipairs(a)do
    if SsdNpc.IsExistNpcType(a)then
      local a=SsdNpc.GetGameObjectPackFilePathsFromNpcType{npcType=a}
      if a~=nil then
        for t,a in ipairs(a)do
          if not this._IsIncludeValueInTable(n,a)then
            table.insert(n,a)
          end
        end
      end
    else
      if not this._IsIncludeValueInTable(n,a)then
        table.insert(n,a)
      end
    end
  end
end
function TppRatBird._EnableBirds(e)
  for e,e in ipairs(mvars.rat_bird_birdList)do
  end
end
function this.SetAnimalLevel(a,n)
  local e=this.AnimalNpcTypeTable[n]
  if not e then
    return
  end
  local a,n=TppStory.GetMissionEnemyLevel()
  TppEnemy._SetEnemyLevel(e,a,n)
end
function this.OnActivateQuest(t)
  if mvars.ani_isQuestSetup==false then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
  end
  local a=false
  if(t.animalList and Tpp.IsTypeTable(t.animalList))and next(t.animalList)then
    for t,n in pairs(t.animalList)do
      if n.animalName then
        if n.colorId then
          this.SetFova(n.animalType,n.animalName,n.colorId)a=true
        end
        if n.animalId then
          this.SetAnimalId(n.animalType,n.animalName,n.animalId)a=true
        end
        if n.kindId then
          this.SetKind(n.animalType,n.animalName,n.kindId)a=true
        end
        if n.routeName then
          if n.animalType=="TppBear"then
            this.SetRoute(n.animalType,n.animalName,n.routeName)
          else
            this.SetHerdRoute(n.animalType,n.animalName,n.routeName)
          end
          a=true
        end
        if n.isNotice then
          this.SetNotice(n.animalType,n.animalName,false)a=true
        end
        if n.isIgnoreNotice then
          this.SetIgnoreNotice(n.animalType,n.animalName,true)a=true
        end
        if n.isSleep then
          this.SetSleep(n.animalType,n.animalName,n.isSleep)a=true
        end
      end
      if n.birdList then
        this.SetBird(n.birdList)a=true
      end
    end
  end
  local n={messageId="None",idType="animalId"}
  local i={messageId="None",idType="databaseId"}
  if mvars.ani_isQuestSetup==false then
    if(t.targetAnimalList and Tpp.IsTypeTable(t.targetAnimalList))and next(t.targetAnimalList)then
      local e=t.targetAnimalList
      if e.markerList then
        for n,e in pairs(e.markerList)do
          TppMarker.SetQuestMarker(e)
          local e=d(e)
          TppBuddyService.SetTargetAnimalId(e)
          table.insert(mvars.ani_questGameObjectIdList,e)
        end
      end
      if e.animalIdList then
        for t,e in pairs(e.animalIdList)do
          mvars.ani_questTargetList[e]=n
          a=true
        end
      end
      if e.dataBaseIdList then
        for n,e in pairs(e.dataBaseIdList)do
          mvars.ani_questTargetList[e]=i
          a=true
        end
      end
    end
  end
  if a==true then
    mvars.ani_isQuestSetup=true
  end
end
function this.OnDeactivateQuest(n)
  if mvars.ani_isQuestSetup==true then
    if(n.animalList and Tpp.IsTypeTable(n.animalList))and next(n.animalList)then
      for a,n in pairs(n.animalList)do
        if n.animalName then
          if n.isNotice then
            this.SetNotice(n.animalType,n.animalName,true)
          end
          if n.isIgnoreNotice then
            this.SetIgnoreNotice(n.animalType,n.animalName,false)
          end
        end
      end
    end
  end
end
function this.OnTerminateQuest(e)
  TppBuddyService.RemoveTargetAnimalId()
  if mvars.ani_isQuestSetup==true then
    mvars.ani_questTargetList={}
    mvars.ani_questGameObjectIdList={}
    mvars.ani_isQuestSetup=false
  end
end
function this.CheckQuestAllTarget(d,a,n,t)
  if not Tpp.IsAnimal(n)then
    return
  end
  local n=TppDefine.QUEST_CLEAR_TYPE.NONE
  local i=this.GetDataBaseIdFromAnimalId(t)
  local t=t
  local e=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(e)then
    return n
  end
  for n,e in pairs(mvars.ani_questTargetList)do
    if e.idType=="animalId"then
      if n==t then
        e.messageId=a or"None"end
    elseif e.idType=="databaseId"then
      if n==i then
        e.messageId=a or"None"end
    end
  end
  local a=0
  local i=0
  local e=0
  local t=0
  for n,e in pairs(mvars.ani_questTargetList)do
    if e.messageId~="None"then
      if e.messageId=="Fulton"then
        a=a+1
      elseif e.messageId=="Dead"then
        t=t+1
      elseif e.messageId=="FultonFailed"then
        i=i+1
      end
    end
  end
  local e=0
  for n,n in pairs(mvars.ani_questTargetList)do
    e=e+1
  end
  if e>0 then
    if d==TppDefine.QUEST_TYPE.ANIMAL_RECOVERED then
      if a>=e then
        n=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif i>0 or t>0 then
        n=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      end
    end
  end
  return n
end
function this.IsQuestTarget(e)
  if mvars.ani_isQuestSetup==false then
    return false
  end
  if not next(mvars.ani_questGameObjectIdList)then
    return false
  end
  for a,n in pairs(mvars.ani_questGameObjectIdList)do
    if e==n then
      return true
    end
  end
  return false
end
function this._IsIncludeValueInTable(n,e)
  for a,n in pairs(n)do
    if n==e then
      return true
    end
  end
  return false
end
return this
