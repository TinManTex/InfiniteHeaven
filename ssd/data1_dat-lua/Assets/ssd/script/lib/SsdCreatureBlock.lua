local this={}
local creature_blockStr="creature_block"
local SCRIPT_BLOCK_STATE_EMPTY=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
local SCRIPT_BLOCK_STATE_PROCESSING=ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
local SCRIPT_BLOCK_STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
local SCRIPT_BLOCK_STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local unkMTable1={}
function this.OnAllocate(e)
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.InitMVars()
  this.InitializeInfoList()
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.InitMVars()
  this.InitializeInfoList()
end
function this.OnUpdate()
  local blockState=this.GetBlockState()
  if not blockState then
    return
  end
  local crb_requestedLoad=mvars.crb_requestedLoad
  local crb_requestedUnload=mvars.crb_requestedUnload
  if not crb_requestedLoad and not crb_requestedUnload then
    return
  end
  if crb_requestedLoad then
    if blockState==SCRIPT_BLOCK_STATE_INACTIVE or blockState==SCRIPT_BLOCK_STATE_ACTIVE then
      local n,t=Tpp.GetCurrentStageSmallBlockIndex()
      this.OnUpdateSmallBlockIndex(n,t)
      mvars.crb_requestedLoad=false
      Mission.SendMessage("Mission","OnEndLoadingCreatureBlock",mvars.crb_currentInfoName)
    end
  elseif crb_requestedUnload then
    if blockState==SCRIPT_BLOCK_STATE_EMPTY then
      mvars.crb_requestedUnload=false
    end
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    Block={
      {msg="StageBlockCurrentSmallBlockIndexUpdated",func=this.OnUpdateSmallBlockIndex,option={isExecFastTravel=true}},
      {msg="OnScriptBlockStateTransition",func=function(blockNameS32,blockState)
        if blockNameS32==Fox.StrCode32(creature_blockStr)then
          if blockState==ScriptBlock.TRANSITION_ACTIVATED then
            local e
            for t,n in ipairs(mvars.crb_loadableInfoList)do
              local infoList=n.infoList
              if infoList then
                for t,n in ipairs(infoList)do
                  local t=n.name
                  if t==mvars.crb_currentInfoName then
                    e=n
                  end
                end
              end
            end
            if e then
              local enemyTypeTable=e.enemyTypeTable or nil
              local enemyLevel=e.enemyLevel or 0
              local enemyLevelRandomRange=e.enemyLevelRandomRange or 0
              local isSequenceEnemyLevel=e.isSequenceEnemyLevel or false
              TppEnemy.SetEnemyLevelCreatureBlock(enemyTypeTable,enemyLevel,enemyLevelRandomRange,isSequenceEnemyLevel)
            end
          end
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}}
end
function this.OnMessage(r,o,l,c,a,n,t)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,o,l,c,a,n,t)
end
function this.InitializeBlockStatus()
  local scriptBlockId=ScriptBlock.GetScriptBlockId(creature_blockStr)
  if scriptBlockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  TppScriptBlock.ClearSavedScriptBlockInfo(scriptBlockId)
end
function this.InitializeInfoList()
  mvars.crb_loadableInfoList={}
  local packList={}
  local locationCode=vars.locationCode
  local CREATURE_BLOCK_INFO_LIST=SsdCreatureList.CREATURE_BLOCK_INFO_LIST
  unkMTable1={}
  for i,blockInfo in ipairs(CREATURE_BLOCK_INFO_LIST)do
    if blockInfo.locationId==locationCode then
      table.insert(mvars.crb_loadableInfoList,blockInfo)
      for j,creatureInfo in ipairs(blockInfo.infoList)do
        local name=creatureInfo.name
        packList[name]={}
        for k,packPath in ipairs(creatureInfo.pack)do
          table.insert(packList[name],packPath)
        end
        local npcs=creatureInfo.npcs
        if npcs~=nil then
          unkMTable1[name]=npcs
          local packPaths=this.GetNpcPackagePathList(npcs)
          if packPaths then
            for k,packPath in ipairs(packPaths)do
              table.insert(packList[name],packPath)
            end
          end
        end
      end
    end
  end
  TppScriptBlock.RegisterCommonBlockPackList(creature_blockStr,packList)
end
function this.InitializeLoad()
  local blockState=this.GetBlockState()
  if not blockState then
    return
  end
  local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()
  this.OnUpdateSmallBlockIndex(blockIndexX,blockIndexY)
end
function this.GetCurrentInfoName()
  return mvars.crb_currentInfoName
end
function this.InitMVars()
  mvars.crb_currentInfoName=nil
  mvars.crb_currentInfo=nil
  mvars.crb_requestedLoad=false
  mvars.crb_requestedUnload=false
end
function this.GetBlockState()
  local scriptBlockId=ScriptBlock.GetScriptBlockId(creature_blockStr)
  if scriptBlockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(scriptBlockId)
end
function this.Load(packName)
  local t=unkMTable1[packName]
  if t then
    this.AssignNpcInfosToGameObjectType(t)
  end
  local e=TppScriptBlock.Load(creature_blockStr,packName)
  if e==false then
  end
  mvars.crb_requestedLoad=true
  return e
end
function this.Unload()
  TppScriptBlock.Unload(creature_blockStr)
  mvars.crb_currentInfoName=nil
  mvars.crb_currentInfo=nil
  mvars.crb_requestedUnload=true
end
function this.ActivateBlock()
  local scriptBlockId=ScriptBlock.GetScriptBlockId(creature_blockStr)
  TppScriptBlock.ActivateScriptBlockState(scriptBlockId)
end
function this.DeactivateBlock()
  local scriptBlockId=ScriptBlock.GetScriptBlockId(creature_blockStr)
  TppScriptBlock.DeactivateScriptBlockState(scriptBlockId)
end
function this.OnUpdateSmallBlockIndex(blockIndexX,blockIndexY)
  local blockState=this.GetBlockState()
  if not blockState then
    return
  end
  if(blockState==SCRIPT_BLOCK_STATE_EMPTY)then
    this.UpdateBlockStateAtNotLoaded(blockIndexX,blockIndexY)
  elseif(blockState==SCRIPT_BLOCK_STATE_PROCESSING)then
  elseif(blockState==SCRIPT_BLOCK_STATE_INACTIVE)then
    this.UpdateBlockStateAtInactive(blockIndexX,blockIndexY)
  elseif(blockState==SCRIPT_BLOCK_STATE_ACTIVE)then
    this.UpdateBlockStateAtActive(blockIndexX,blockIndexY)
  end
end
function this.UpdateBlockStateAtNotLoaded(blockIndexX,blockIndexY)
  local crb_loadableInfoList=mvars.crb_loadableInfoList
  if not crb_loadableInfoList then
    return
  end
  if not Tpp.IsTypeTable(crb_loadableInfoList)or not next(crb_loadableInfoList)then
    return
  end
  local n=this.SearchProperInfo("loadArea",blockIndexX,blockIndexY)
  if not n then
    return
  end
  local e=this.Load(n)
  if e==false then
    mvars.crb_currentInfoName=nil
    mvars.crb_currentInfo=nil
  end
end
function this.UpdateBlockStateAtInactive(t,r)
  local n=mvars.crb_currentInfo
  if not n then
    this.Unload()
    return
  end
  if mvars.crb_requestedUnload then
    return
  end
  if not this.IsInsideArea("loadArea",n,t,r)then
    this.Unload()
    return
  end
  if this.IsInsideArea("activeArea",n,t,r)then
    this.ActivateBlock()
  end
end
function this.UpdateBlockStateAtActive(t,r)
  local n=mvars.crb_currentInfo
  if not n then
    this.Unload()
    return
  end
  if mvars.crb_requestedUnload then
    return
  end
  if not this.IsInsideArea("loadArea",n,t,r)then
    this.Unload()
    return
  end
  if not this.IsInsideArea("activeArea",n,t,r)then
    this.DeactivateBlock()
  end
end
function this.SearchProperInfo(r,t,a)
  local crb_loadableInfoList=mvars.crb_loadableInfoList
  for o,n in ipairs(crb_loadableInfoList)do
    if this.IsInsideArea(r,n,t,a)then
      for t,e in ipairs(n.infoList)do
        if e.loadCondition and e.loadCondition()then
          mvars.crb_currentInfoName=e.name
          mvars.crb_currentInfo=n
          return e.name
        end
      end
    end
  end
end
function this.IsInsideArea(t,e,n,r)
  if not e then
    return
  end
  local e=e[t]
  if e==nil then
    return
  end
  return Tpp.CheckBlockArea(e,n,r)
end
function this.AssignNpcInfosToGameObjectType(e)
  for n,e in ipairs(e)do
    SsdNpc.AssignInfosToGameObjectType{gameObjectType=e[1],npcType=e[2],partsType=e[3]}
  end
end
function this.GetNpcPackagePathList(npcs)
  local packPaths={}
  for i,npcInfo in ipairs(npcs)do
    local partsPackPaths=SsdNpc.GetGameObjectPackFilePathsFromPartsType{partsType=npcInfo[3]}
    for j,packPath in ipairs(partsPackPaths)do
      table.insert(packPaths,packPath)
    end
  end
  return packPaths
end
function this.QARELEASE_DEBUG_Init()
  local e
  if DebugMenu then
    e=DebugMenu
  else
    return
  end
  mvars.qaDebug.showCurrentCrbState=false
  e.AddDebugMenu("CreatureBlock","showCurrentState","bool",mvars.qaDebug,"showCurrentCrbState")
end
function this.QAReleaseDebugUpdate()
  local Print=DebugText.Print
  local context=DebugText.NewContext()
  if mvars.qaDebug.showCurrentCrbState then
    Print(context,"")
    Print(context,{.5,.5,1},"CreatureBlock")
    local r=this.GetBlockState()
    if r==nil then
      Print(context,"Block State : CreatureBlock isn't found...")
      return
    end
    local stringForState={}
    stringForState[SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"
    stringForState[SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"
    stringForState[SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"
    stringForState[SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"
    Print(context,"Block State : "..tostring(stringForState[r]))
    Print(context,"Reqessted Load   : "..tostring(mvars.crb_requestedLoad))
    Print(context,"Requested Unload : "..tostring(mvars.crb_requestedUnload))
    if mvars.crb_currentInfoName and mvars.crb_currentInfo then
      Print(context,"Loaded Info : "..tostring(mvars.crb_currentInfoName))
      for e,r in ipairs(mvars.crb_currentInfo.infoList)do
        if r.name==mvars.crb_currentInfoName then
          local e=1
          for a,r in ipairs(r.pack)do
            Print(context,"Loaded Pack["..(tostring(e)..("] : "..tostring(r))))
            e=e+1
          end
          break
        end
      end
      local e,r=Tpp.GetCurrentStageSmallBlockIndex()
      Print(context,"CurrentBlock : ("..(tostring(e)..(", "..(tostring(r)..")"))))
      local e=mvars.crb_currentInfo.loadArea
      Print(context,"LoadArea   : ("..(tostring(e[1])..(", "..(tostring(e[2])..(")/("..(tostring(e[3])..(", "..(tostring(e[4])..")"))))))))
      e=mvars.crb_currentInfo.activeArea
      Print(context,"ActiveArea : ("..(tostring(e[1])..(", "..(tostring(e[2])..(")/("..(tostring(e[3])..(", "..(tostring(e[4])..")"))))))))
    end
  end
end
return this
