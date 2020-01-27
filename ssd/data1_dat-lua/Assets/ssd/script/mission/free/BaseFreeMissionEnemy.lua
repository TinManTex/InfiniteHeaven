-- BaseFreeMissionEnemy.lua
local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeTable=Tpp.IsTypeTable
local GetGameObjectId=GameObject.GetGameObjectId
local GetGameObjectIdByIndex=GameObject.GetGameObjectIdByIndex
function this.CreateInstance(missionName)
  local instance={}
  instance.requires={}
  instance.missionName=missionName
  instance.soldierDefine={cp_base={nil},nil}
  instance.routeSets={cp_base={priority={"groupA"},sneak_day={groupA={}},sneak_night={groupA={}},caution={groupA={}},hold={default={}},nil},nil}
  instance.combatSetting={cp_base={},nil}
  function instance.InitEnemy()
  end
  function instance.SetUpEnemy()
    instance.SetWave()
    instance.SetWormHoleDropInstanceCount()
    instance.SetVehicle()
    instance.SetWalkerGear()
    instance.SetCreature()
    instance.SetStartKaiju(true)
  end
  function instance.OnLoad()
  end
  function instance.GetSpawnLocatorNames(waveName)
    local waveSettingTable=instance.waveSettingTable
    if Tpp.IsTypeTable(waveSettingTable)then
      local locatorNames={}
      local waveInfo=waveSettingTable[waveName]
      while waveInfo do
        if waveInfo.endLoop then
          break
        end
        local spawnTableName=waveInfo.spawnTableName
        if spawnTableName then
          local spawnSetting=instance.spawnSettingTable[spawnTableName]
          if Tpp.IsTypeTable(spawnSetting)then
            local locatorSet=spawnSetting.locatorSet
            if Tpp.IsTypeTable(locatorSet)then
              local spawnLocator=locatorSet.spawnLocator
              if spawnLocator then
                local addToTable=true
                for i,_locatorName in ipairs(locatorNames)do
                  if _locatorName==spawnLocator then
                    addToTable=false
                  end
                end
                if addToTable then
                  table.insert(locatorNames,spawnLocator)
                end
                waveInfo=instance.waveSettingTable[waveInfo.nextWave]
              else
                waveInfo=nil
              end
            end
          end
        end
      end
      return locatorNames
    end
  end
  function instance.SetWave()
    if mvars.loc_locationCommomnWaveSettings then
      local locationCommomnWaveSettings={
        mvars.loc_locationCommomnWaveSettings.waveList,
        mvars.loc_locationCommomnWaveSettings.propertyTable,
        mvars.loc_locationCommomnWaveSettings.waveTable,
        mvars.loc_locationCommomnWaveSettings.spawnPointDefine
      }
      TppMission.RegisterFreePlayWaveSetting(locationCommomnWaveSettings)
      TppMission.SetUpWaveSetting{locationCommomnWaveSettings}
    end
  end
  function instance.SetCreature()
    local creatureDataTable=instance.creatureDataTable
    if IsTypeTable(creatureDataTable)then
      for name,creatureInfo in pairs(creatureDataTable)do
        if creatureInfo.enemytype=="SsdZombie"or creatureInfo.enemytype=="SsdZombieDash"then
          local gameObjectType={type=creatureInfo.enemytype}
          if creatureInfo.route then
            local command={id="SetSneakRoute",route=creatureInfo.route,name=name,point=0}
            GameObject.SendCommand(gameObjectType,command)
          end
        elseif creatureInfo.enemytype=="SsdInsect1"then
          local gameObjectId=GameObject.GetGameObjectId(creatureInfo.enemytype,name)
          if gameObjectId~=NULL_ID then--RETAILBUG
            if creatureInfo.route then
              local command={id="SetSneakRoute",route=creatureInfo.route,name=name,point=0}
              GameObject.SendCommand(gameObjectId,command)
            end
            if creatureInfo.target then
              local command={id="SetSneakTarget",target=creatureInfo.target}
              GameObject.SendCommand(gameObjectId,command)
            end
          end
        elseif creatureInfo.enemytype=="SsdInsect2"then
          local gameObjectId=GameObject.GetGameObjectId(creatureInfo.enemytype,name)
          if gameObjectId~=NULL_ID then--RETAILBUG
            if creatureInfo.route then
              local command={id="SetSneakRoute",route=creatureInfo.route,name=name,point=0}
              GameObject.SendCommand(gameObjectId,command)
            end
            if creatureInfo.isStiction then
              local command={id="SetSpider",isProwl=true,isStiction=true}
              GameObject.SendCommand(gameObjectId,command)
            end
          end
        end
      end
    end
  end
  function instance.SetVehicle()
    local spawnList=instance.spawnList
    if IsTypeTable(spawnList)then
      for i,spawnInfo in ipairs(spawnList)do
        GameObject.SendCommand({type="TppVehicle2"},spawnInfo)
      end
    end
  end
  function instance.SetWalkerGear()
    local walkerGearTableList=instance.walkerGearTableList
    if IsTypeTable(walkerGearTableList)then
      for i,walkerInfo in ipairs(walkerGearTableList)do
        local gameObjectId=GetGameObjectId(walkerInfo.name)
        if gameObjectId~=NULL_ID then--RETAILBUG:
          GameObject.SendCommand(gameObjectId,{id="SetEnabled",enabled=false})
          if walkerInfo.coloringType then
            GameObject.SendCommand(gameObjectId,{id="SetColoringType",type=walkerInfo.coloringType})
          end
        end
      end
    end
  end
  function instance.SetWormHoleDropInstanceCount()
    if IsTypeTable(mvars.loc_locationWormholeQuest)and IsTypeTable(mvars.loc_locationWormholeQuest.wormholeDropInstanceCountTable)then
      for i,wormholeDropInfo in pairs(mvars.loc_locationWormholeQuest.wormholeDropInstanceCountTable)do
        if GameObject.GetGameObjectIdByIndex(wormholeDropInfo.gameObjectType,0)~=GameObject.NULL_ID then
          local gameObjectType={type=wormholeDropInfo.gameObjectType}
          local command={id="SetDropInstanceCount",count=wormholeDropInfo.count}
          GameObject.SendCommand(gameObjectType,command)
        end
      end
    end
  end
  function instance.SetStartKaiju(setPosition)
    local storySequence=TppStory.GetCurrentStorySequence()
    local railInfo=nil
    local kaijuRailList=instance.kaijuRailList--NMC f30010_enemy.kaijuRailList
    local validRailInfos={}
    local priorityRailInfo=nil
    local setEnabledFromStart=false
    if storySequence<=TppDefine.STORY_SEQUENCE.CLEARED_k40030 or (storySequence>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST) then
      return
    end
    if IsTypeTable(kaijuRailList)then
      for i,_railInfo in ipairs(kaijuRailList)do
        if _railInfo.railName and _railInfo.pos then
          if storySequence==_railInfo.sequence and _railInfo.isPriority==true then
            priorityRailInfo=_railInfo
          elseif storySequence>=_railInfo.sequence then
            table.insert(i,_railInfo)
          end
        end
      end
      if priorityRailInfo~=nil then
        railInfo=priorityRailInfo
      else
        if#validRailInfos==0 then
          return
        end
        local rndIndex=math.random(1,#validRailInfos)
        railInfo=validRailInfos[rndIndex]
      end
      if IsTypeTable(railInfo)then
        setEnabledFromStart=false
        if storySequence>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST and storySequence<=TppDefine.STORY_SEQUENCE.BEFORE_STORY_LAST then
          if setPosition==true or TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")and railInfo.pos then
            TppEnemy.SetKaijuRailOneArmedStartPosition(railInfo.railName,railInfo.pos)
          else
            TppEnemy.SetKaijuRailOneArmed(railInfo.railName)
          end
          setEnabledFromStart=true
        else
          if setPosition==true or TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")and railInfo.pos then
            TppEnemy.SetKaijuRailStartPosition(railInfo.railName,railInfo.pos)
          else
            TppEnemy.SetKaijuRail(railInfo.railName)
          end
          setEnabledFromStart=true
        end
        if setEnabledFromStart==true then
          TppEnemy.SetEnableKaiju()
        end
      end
    end
  end
  function instance.SetEndKaiju()
    TppEnemy.SetDisableKaiju()
    local time=instance.KaijuEnableTimer or(60*2)
    GkEventTimerManager.Start("TimerKaijuEnable",time)
  end
  return instance
end
return this
